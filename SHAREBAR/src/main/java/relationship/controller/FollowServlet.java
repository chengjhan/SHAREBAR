package relationship.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
import relationship.model.RelationshipService;

@WebServlet("/member/FollowChange.do")
public class FollowServlet extends HttpServlet {
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
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		MemberBean user = (MemberBean) request.getSession().getAttribute("user");
		if(user == null){
			out.write("nonLogin");
			return;
		}
		String temp = request.getParameter("id");
		int memberNo = Integer.valueOf(temp);
		String status = request.getParameter("status");
		System.out.println("memberNo= "+memberNo+"status= "+status);
		// System.out.println(memberNo);
		MemberBean member = memberService.findById(memberNo);
		// String user2check = relationshipService.checkRel(user, member);
		// System.out.println("user2check= "+user2check);
		// String check2user = relationshipService.checkRel(member, user);
		// System.out.println("check2user= "+check2user);
		if (member != null) {
			System.out.println("change follow...");
			Boolean addFollow = relationshipService.changeFollow(user, member, status);
			String user2check = relationshipService.checkRel(user, member);
			System.out.println("user2check= "+user2check);
			if (addFollow) {
				out.write("success");
				return;
			} else {
				out.write("fail");
				return;
			}
		} else {
			String path = request.getContextPath();
			response.sendRedirect(path + "/index.jsp");
			return;
		}
	}

}
