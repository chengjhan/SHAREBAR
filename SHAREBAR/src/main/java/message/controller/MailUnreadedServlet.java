package message.controller;

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

import message.model.MessageContextService;

@WebServlet("/mailUnreaded.ajax")
public class MailUnreadedServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	@Autowired
	private MessageContextService messageContextService;
	
	@Override	
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		messageContextService = (MessageContextService) context.getBean("messageContextService");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
				
		int number = 0;
		
		// 接受資料
		int member_id = Integer.valueOf(request.getParameter("user"));
		
		// 呼叫Model
		number = messageContextService.mailUnreaded(member_id);
		
		PrintWriter out = response.getWriter();
//		System.out.println("系統：會員(" + member_id + ")信箱未讀數量為" + number);
		out.write(String.valueOf(number));
						
	}

}
