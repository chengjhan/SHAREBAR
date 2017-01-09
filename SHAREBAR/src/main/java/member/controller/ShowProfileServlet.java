package member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import item.model.ItemService;
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

	@Autowired
	ItemService itemService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
		relationshipService = (RelationshipService) context.getBean("relationshipService");
		itemService = (ItemService) context.getBean("itemService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		MemberBean user = (MemberBean) request.getSession().getAttribute("user");
		String temp = request.getParameter("id");
		int memberNo = Integer.valueOf(temp);
//		System.out.println(memberNo);
		MemberBean member = memberService.findById(memberNo);
		String user2check = null;
		if (member != null) {
			List<RelationshipBean> follow = relationshipService.findFollow(member);
			List<RelationshipBean> followed = relationshipService.findFollowed(member);

			// create giverReviews json
			JSONArray giveJa = new JSONArray();
			List<Object[]> results = itemService.selectGiveReview(member);
			int resultsCount = 0;
			int goodpoint =  0;
			int normalpoint = 0;
			int badpoint = 0;
			JSONObject asGiver;
			if (results != null) {
				for (Object[] result : results) {
					MemberBean getter = (MemberBean) result[0];
					int member_no = getter.getMember_no();
					String member_photo = getter.getPhoto();
					Integer giverRate = (Integer) result[1];
					String giverReview = (String) result[2];
					JSONObject jo = new JSONObject();
					jo.put("getterID", member_no);
					jo.put("getterPhoto", member_photo);
					jo.put("giverRate", giverRate);
					if(giverRate==3){
						goodpoint++;
					}else if(giverRate==2){
						normalpoint++;
					}else if(giverRate==1){
						badpoint++;
					}
					jo.put("giverReview", giverReview);
					giveJa.put(jo);
					resultsCount++;
				}
				asGiver = new JSONObject();
				asGiver.put("giverReviews", giveJa);
				asGiver.put("Count", resultsCount);
				asGiver.put("good", goodpoint);
				asGiver.put("normal", normalpoint);
				asGiver.put("bad", badpoint);
			}else{
				asGiver = new JSONObject();
				asGiver.put("giverReviews","");
				asGiver.put("Count",resultsCount);
				asGiver.put("good", goodpoint);
				asGiver.put("normal", normalpoint);
				asGiver.put("bad", badpoint);
			}
			// giverReviews json complete
			
			// create getterReviews json
			JSONArray getJa = new JSONArray();
			results = itemService.selectGetReview(member);
			resultsCount = 0;
			goodpoint =  0;
			normalpoint = 0;
			badpoint = 0;
			JSONObject asGetter;
			if(results!=null){
				for (Object[] result : results) {
					MemberBean giver = (MemberBean) result[0];
					int member_no = giver.getMember_no();
					String member_photo = giver.getPhoto();
					Integer getterRate = (Integer) result[1];
					String getterReview = (String) result[2];
					JSONObject jo = new JSONObject();
					jo.put("giverID", member_no);
					jo.put("giverPhoto", member_photo);
					jo.put("getterRate", getterRate);
					if(getterRate==3){
						goodpoint++;
					}else if(getterRate==2){
						normalpoint++;
					}else if(getterRate==1){
						badpoint++;
					}
					jo.put("getterReview", getterReview);
					getJa.put(jo);
					resultsCount++;
				}
				asGetter = new JSONObject();
				asGetter.put("getterReviews", getJa);
				asGetter.put("Count", resultsCount);
				asGetter.put("good", goodpoint);
				asGetter.put("normal", normalpoint);
				asGetter.put("bad", badpoint);
			}else{
				asGetter = new JSONObject();
				asGetter.put("getterReviews","");
				asGetter.put("Count",resultsCount);
				asGetter.put("good", goodpoint);
				asGetter.put("normal", normalpoint);
				asGetter.put("bad", badpoint);
			}
			// getterReviews json complete
			

			if (user != null) {
				if (user.getMember_no() == member.getMember_no()) {
					request.getSession().setAttribute("user", member);
					request.getSession().setAttribute("userFollow", follow);
					request.getSession().setAttribute("userFollowed", followed);
					request.getSession().setAttribute("userasGiver", asGiver);
					request.getSession().setAttribute("userasGetter", asGetter);
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
					request.setAttribute("memberasGiver", asGiver);
					request.setAttribute("memberasGetter", asGetter);
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
					request.setAttribute("memberasGiver", asGiver);
					request.setAttribute("memberasGetter", asGetter);
					request.getRequestDispatcher("/member/memberProfile.jsp").forward(request, response);
				}
			}
		} else {
			String path = request.getContextPath();
			response.sendRedirect(path + "/index.jsp");
			return;
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
