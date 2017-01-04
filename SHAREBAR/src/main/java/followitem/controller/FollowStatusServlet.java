package followitem.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import followitem.model.FollowItemsService;




@WebServlet("/followitems/itemStatus.do")
public class FollowStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FollowItemsService followeritemservice;
	
       
	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		followeritemservice = (FollowItemsService) context.getBean("followItemsService");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setHeader("content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		int member_no = 0;
		int item_id = 0;
		
		String member_no_check = request.getParameter("MemberID");
		String item_id_check = request.getParameter("ItemID");
		

		
		if (!(member_no_check == null) && !(item_id_check == null)){
			member_no = Integer.parseInt(member_no_check);
			item_id = Integer.parseInt(item_id_check);
		}
		else{
			request.setAttribute("result", "no data");
		}
		
		int result = followeritemservice.followStatus(member_no, item_id);
		
		String change = String.valueOf(result);
		
		System.out.println("獲得商品狀態:"+result);
		
		response.getWriter().write(change);
		request.setAttribute("status", result);
		
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		
	}


}
