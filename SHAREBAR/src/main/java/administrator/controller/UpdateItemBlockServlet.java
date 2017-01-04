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

import item.model.ItemBean;
import item.model.ItemService;


@WebServlet("/administrator/UpdateItemBlockServlet")
public class UpdateItemBlockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// private ReportDAO reportDAO;
	@Autowired
	ItemService itemService;


	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemService = (ItemService) context.getBean("itemService");
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String,String> errors = new HashMap<String,String>();
		
		String item_id = request.getParameter("item_id");

		
		request.setAttribute("errors", errors);
		
		if (item_id == null || item_id.length() == 0) {
			errors.put("system3", "Item ID is required");
		}
		if (item_id.length() >= 9) {
			errors.put("system3", "ID length must <9");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
			rd.forward(request, response);
			return;
		}
		
		int int_item_id = 0;
		 try {
			 
			 int_item_id = Integer.valueOf(item_id);
			
		} catch (NumberFormatException e) {
			errors.put("system3", "please enter correct Id number");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
			rd.forward(request, response);
			return;
		} catch(NullPointerException e2){
			errors.put("system3", "can't find this ID number");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
			rd.forward(request, response);
			return;
		}

		ItemBean itembean = itemService.updateItemBlock(int_item_id); 
		System.out.println(itembean);
		if(itembean!=null){
		
		List<ItemBean> itemBean = itemService.selectBlockItem();
		request.setAttribute("item", itemBean);
		RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
		rd.forward(request, response);
		return;
		
		}else{
			errors.put("system3", "can not find this ID");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
			rd.forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
