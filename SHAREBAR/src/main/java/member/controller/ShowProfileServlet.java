package member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;
import relationship.model.RelationshipBean;
import relationship.model.RelationshipService;

@WebServlet("/member/profile.controller")
public class ShowProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	MemberService memberService;

	@Autowired
	RelationshipService relationshipService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
		relationshipService = (RelationshipService) context.getBean("relationshipService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		MemberBean user = (MemberBean) request.getSession().getAttribute("user");
		String temp = request.getParameter("id");
		int memberNo = Integer.valueOf(temp);
		System.out.println(memberNo);
		MemberBean member = memberService.findById(memberNo);
		String user2check = null;
		if (member != null) {
			List<RelationshipBean> follow = relationshipService.findFollow(member);
			List<RelationshipBean> followed = relationshipService.findFollowed(member);
			if (user != null) {
				if (user.getMember_no() == member.getMember_no()) {
					request.getSession().setAttribute("user", member);
					request.getSession().setAttribute("userFollow", follow);
					request.getSession().setAttribute("userFollowed", followed);
					request.getRequestDispatcher("/member/userProfile.jsp").forward(request, response);
					return;
				} else {
					user2check = relationshipService.checkRel(user, member);
					if (user2check == null) {
						user2check = "unfollow";
					}
					request.setAttribute("member", member);
					request.setAttribute("memberFollow", follow);
					request.setAttribute("memberFollowed", followed);
					request.setAttribute("user2check", user2check);
					request.getRequestDispatcher("/member/memberProfile.jsp").forward(request, response);
					return;
				}

			} else {
				if (member != null) {
					user2check = "unfollow";
					request.setAttribute("member", member);
					request.setAttribute("memberFollow", follow);
					request.setAttribute("memberFollowed", followed);
					request.setAttribute("user2check", user2check);
					request.getRequestDispatcher("/member/memberProfile.jsp").forward(request, response);
				}
			}
		} else {
			String path = request.getContextPath();
			response.sendRedirect(path + "/index.jsp");
			return;
		}
		// String check2user = relationshipService.checkRel(member, user);
		// System.out.println("check2user= "+check2user);
		// if(member != null){
		// request.setAttribute("member", member);
		// request.setAttribute("user2check", user2check);
		// request.getRequestDispatcher(
		// "/member/memberProfile.jsp").forward(request, response);
		// return;
		// }else{
		// String path = request.getContextPath();
		// response.sendRedirect(path+"/index.jsp");
		// return;
		// }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
