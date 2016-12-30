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

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import administrator.model.ReportBean;
import administrator.model.ReportService;
import item.model.ItemBean;
import item.model.ItemService;
import member.model.MemberBean;
import member.model.MemberService;



@WebServlet("/administrator/ReportInsertServlet")
public class ReportInsertServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
    
	private ReportService reportService;
	private MemberService memberService;
	private ItemService itemService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		reportService = (ReportService) context.getBean("reportService");
		memberService = (MemberService) context.getBean("memberService");
		itemService = (ItemService) context.getBean("itemService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String, String> errors = new HashMap<String, String>();	
		request.setAttribute("errors", errors);

		String reporting_member_id = request.getParameter("reporting_member_id");
		String reported_item_id = request.getParameter("reported_item_id");
		String context = request.getParameter("context");
		
		if (reporting_member_id == null || reporting_member_id.length() == 0) {
			errors.put("system", "member ID is required");
		}
		if (reporting_member_id.length() >= 9) {
			errors.put("system", "ID length must <9");
		}
		if (reported_item_id == null || reported_item_id.length() == 0) {
			errors.put("system", "item ID is required");
		}
		if (reported_item_id.length() >= 9) {
			errors.put("system", "ID length must <9");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);
			return;
		}
		
		try {
			Integer.valueOf(reporting_member_id);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			errors.put("system","please enter right member ID ");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);
			return;
		}
		try {
			Integer.valueOf(reported_item_id);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			errors.put("system","please enter right item ID ");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);
			return;
		} 
		

		
		int int_reporting_member_id = Integer.valueOf(reporting_member_id);
		int int_reported_item_id = Integer.valueOf(reported_item_id);
		
		MemberBean memberBean = memberService.findById(int_reporting_member_id);
		ItemBean itemBean = itemService.selectById(int_reported_item_id);
		
		ReportBean bean = new ReportBean();
		
		bean.setReporting_member_id(memberBean);
		bean.setReported_item_id(itemBean);	
		bean.setTime( new java.util.Date() );
		bean.setContext(context);
		
		
		ReportBean reportBean;
		try {
			reportBean = reportService.insertReport(bean);
		}catch (NumberFormatException e) {
			e.printStackTrace();
			errors.put("system","please enter right DATA ");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);
			return;
		}
		catch (Exception e) {
			e.printStackTrace();
			errors.put("system","please enter right DATA ");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);
			return;
		}
		
		
		if(reportBean!=null){			
			request.setAttribute("report2", reportBean);
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);			
			return;
		}else{
			errors.put("system","No Data exist");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view03.jsp");
			rd.forward(request, response);			
			return;
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
