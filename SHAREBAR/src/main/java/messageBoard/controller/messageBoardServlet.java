package messageBoard.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import item.model.ItemBean;
import item.model.ItemService;
import member.model.MemberBean;
import member.model.MemberService;
import messageBoard.model.MessageBoardBean;
import messageBoard.model.MessageBoardService;

/**
 * Servlet implementation class messageBoardServlet
 */
@WebServlet("/item/messageBoard.do")
public class messageBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Autowired
	private MessageBoardService  messageBoardService;
	@Autowired
	private ItemService itmeService;
	@Autowired
	private MemberService memberService;
	
	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		messageBoardService = (MessageBoardService) context.getBean("messageBoardService");
		itmeService = (ItemService) context.getBean("itemService");
		memberService = (MemberService) context.getBean("memberService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setHeader("content-type", "text/html:charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String item_id_check = request.getParameter("ItemID");
		String member_no_check = request.getParameter("MemberID");
		String message = request.getParameter("message");
		
		int item_id = 0;
		int member_no = 0;
		if(item_id_check!=null && member_no_check!=null){
			item_id = Integer.parseInt(item_id_check);
			member_no = Integer.parseInt(member_no_check);
		}
		ItemBean itembean = itmeService.selectById(item_id);
		MemberBean memberbean = memberService.findById(member_no);
		
		System.out.println(itembean);
		System.out.println(memberbean);
		System.out.println(message);
		Boolean result= messageBoardService.addmessage(itembean, memberbean, message);
		System.out.println(result);
			
	}

}
