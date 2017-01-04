package administrator.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import administrator.model.ServiceMailBean;
import administrator.model.ServiceMailService;


@WebServlet("/administrator/MailReplyServlet")
public class MailReplyServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
		    
		@Autowired
		ServiceMailService serviceMailService;
		
		@Override
		public void init() throws ServletException {
			ServletContext application = this.getServletContext();
			ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
			serviceMailService = (ServiceMailService) context.getBean("serviceMailService");
		}
		
		protected void doGet(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			response.setHeader("content-type", "text/html:charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			Map<String, String> errors = new HashMap<String, String>();
			
			request.setAttribute("errors", errors);
			String mail_id = request.getParameter("mail_id");
			String gm_reply_context = request.getParameter("gm_reply_context");
			
			
			if (gm_reply_context == null || gm_reply_context.length() == 0) {
				errors.put("system", "context can't be empty");
			}	
			if (!errors.isEmpty()) {
				RequestDispatcher rd = request.getRequestDispatcher("gm_view04_2.jsp");
				rd.forward(request, response);
				return;
			}
				
			try {
				Integer.valueOf(mail_id);
			} catch (NumberFormatException e) {
				e.printStackTrace();
				errors.put("system","please enter right ID number");
				RequestDispatcher rd = request.getRequestDispatcher("gm_view04_2.jsp");
				rd.forward(request, response);
				return;
			} 
			
			int int_mail_id = Integer.valueOf(mail_id);								
			ServiceMailBean serviceMailBean = serviceMailService.replyMail(int_mail_id, gm_reply_context);
			
			if(serviceMailBean!=null){
			    errors.put("system","mail has post");
				RequestDispatcher rd = request.getRequestDispatcher("gm_view04_2.jsp");
				rd.forward(request, response);
				
			return;
			}else{
				errors.put("system"," post fail");
				RequestDispatcher rd = request.getRequestDispatcher("gm_view04_2.jsp");
				rd.forward(request, response);
				return;
			}
			
			
			
			
		}
		
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
		
			doGet(request, response);
		}


}
