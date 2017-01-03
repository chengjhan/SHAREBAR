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





@WebServlet("/administrator/MailSelectAllServlet")
public class MailSelectAllServlet extends HttpServlet {
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
//		String item_id = request.getParameter("item_id");
		
		
		
		List<ServiceMailBean> serviceMailBean = serviceMailService.selectAllMail();
		
		if(serviceMailBean!=null){	
		
			request.setAttribute("mail", serviceMailBean);
			RequestDispatcher rd = request.getRequestDispatcher("gm_view04_1.jsp");
			rd.forward(request, response);
			
			return;
		}else{
			errors.put("system2","No Data exist");
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
