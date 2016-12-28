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

import item.model.ItemBean;
import item.model.ItemService;


@WebServlet("/administrator/SelectByItemNameServlet")
public class SelectByItemNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

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
		Map<String, String> errors = new HashMap<String, String>();
		
		request.setAttribute("errors", errors);
		String item_id = request.getParameter("item_id");
		
		if (item_id == null || item_id.length() == 0) {
			errors.put("item_id", "item ID is required");
		}
		if (item_id.length() >= 9) {
			errors.put("item_id", "ID length must <9");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
			rd.forward(request, response);
			return;
		}
		
		ItemBean itemBean = null;
		try {
			itemBean = itemService.selectById(Integer.valueOf(item_id));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} 
				
		if (itemBean != null) {
			request.setAttribute("item2", itemBean);

			RequestDispatcher rd = request.getRequestDispatcher("gm_view02.jsp");
			rd.forward(request, response);
			return;
		}else{
			errors.put("system","can't find the item");
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
