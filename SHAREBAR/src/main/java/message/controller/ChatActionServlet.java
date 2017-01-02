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

import message.model.RequestListService;

@WebServlet("/chatAction.ajax")
public class ChatActionServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	@Autowired
	private RequestListService requestListService;

	@Override	
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		requestListService = (RequestListService) context.getBean("requestListService");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String action_str = request.getParameter("action");
		int item_id = Integer.valueOf(request.getParameter("item"));
		int requester_id = Integer.valueOf(request.getParameter("requester"));
		System.out.println( "系統：使用者 ( " + requester_id + " ) 對分享物 " + item_id + action_str );
		String result = null;
		
		if ( null != action_str && "ask".equals(action_str))
			result = requestListService.askConsent(item_id, requester_id);
		
		if ( null != action_str && "acept".equals(action_str))
			result = requestListService.aceptDemand(item_id, requester_id);
		
		if ( null != action_str && "refuse".equals(action_str))
			result = requestListService.refuseDemand(item_id, requester_id);
				
		PrintWriter out = response.getWriter();
		out.write(result);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
