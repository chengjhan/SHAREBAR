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

import item.model.ItemService;

@WebServlet("/rateInsert.ajax")
public class RateInsertServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	@Autowired
	private ItemService itemService;

	@Override	
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemService = (ItemService) context.getBean("itemService");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		int item_id = Integer.valueOf(request.getParameter("item"));
		String target_str = request.getParameter("target");
		int rateScore = Integer.valueOf(request.getParameter("rateScore"));
		String rateMessage = request.getParameter("rateMessage");
		
		System.out.println( "系統：使用者 ( " + target_str + " ) 在分享物 " + item_id + "獲得評價" );
		
		if ( null != target_str && "giver".equals(target_str))
			itemService.rateToGiver(item_id, rateScore, rateMessage);
		
		if ( null != target_str && "getter".equals(target_str))
			itemService.rateToGetter(item_id, rateScore, rateMessage);
				
		PrintWriter out = response.getWriter();
		out.write("success");
	}

}
