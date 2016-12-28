package message.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import message.model.MessageContextService;

@WebServlet("/maillist.controller")
public class MessageListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private MessageContextService messageContextService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		messageContextService = (MessageContextService) context.getBean("messageContextService");
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String member_id = request.getParameter("member_id");
		
		List<Object[]> share_mail = messageContextService.mailForShare(Integer.valueOf(member_id));
		request.setAttribute("share_mail", share_mail);
		
		List<Object[]> request_mail = messageContextService.mailForRequest(Integer.valueOf(member_id));
		request.setAttribute("request_mail", request_mail);
		
		RequestDispatcher rd = request.getRequestDispatcher("message/maillist.jsp");
		rd.forward(request, response);
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
