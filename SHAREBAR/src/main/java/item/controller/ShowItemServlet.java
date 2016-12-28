package item.controller;

import java.io.IOException;

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


@WebServlet("/item/itemdetail.controller")
public class ShowItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Autowired
    private ItemService itemservice;
    

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemservice = (ItemService) context.getBean("itemService");
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setHeader("content-type", "text/html:charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		System.out.println("獲得物品詳細資訊");
		
		String getid =  request.getParameter("id");
		int item_id = Integer.valueOf(getid);
		ItemBean  itembean =  itemservice.selectById(item_id);
		
		request.setAttribute("itembean", itembean);
		
		String path = request.getContextPath();
		
		request.getRequestDispatcher("/item/ItemProfile.jsp").forward(request, response);		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
