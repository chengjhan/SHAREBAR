package administrator.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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


@WebServlet("/administrator/MailSelectMemberNoServlet")
public class MailSelectMemberNoServlet extends HttpServlet {
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
		String member_id = request.getParameter("member_id");
		
		if (member_id == null || member_id.length() == 0) {
			errors.put("system", "item ID is required");
		}
		if (member_id.length() >= 9) {
			errors.put("system", "ID length must <9");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view04_1.jsp");
			rd.forward(request, response);
			return;
		}
		
		List<ServiceMailBean> serviceMailBean = null;
		
		try {
			serviceMailBean = serviceMailService.selectMemberMail(Integer.valueOf(member_id));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			errors.put("system","please enter right ID number");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view04_1.jsp");
			rd.forward(request, response);
			return;
		} 
		
		serviceMailBean = serviceMailService.selectMemberMail(Integer.valueOf(member_id));
		
		if(serviceMailBean!=null){	
		
			request.setAttribute("mail", serviceMailBean);
			RequestDispatcher rd = request.getRequestDispatcher("gm_view04_1.jsp");
			rd.forward(request, response);
			
			return;
		}else{
			errors.put("system","No Data exist");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view04_1.jsp");
			rd.forward(request, response);
			
			return;
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
