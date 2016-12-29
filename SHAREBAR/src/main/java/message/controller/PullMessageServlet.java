package message.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import message.model.MessageContextBean;
import message.model.MessageContextService;

@WebServlet("/pullMessage.ajax")
public class PullMessageServlet extends HttpServlet {
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
		response.setContentType("text/html; charset=UTF-8");

		// 接受資料
		int item_id = Integer.valueOf(request.getParameter("item"));
		int requester_id = Integer.valueOf(request.getParameter("requester"));
		System.out.println(item_id);
		System.out.println(requester_id);
						
		// 呼叫Model
		GsonBuilder builder = new GsonBuilder();
		builder.excludeFieldsWithoutExposeAnnotation();
		Gson gson = builder.create();

		List<MessageContextBean> result = messageContextService.select(item_id, requester_id);		
		System.out.println(result);		
		
		String json = gson.toJson(result);
		System.out.println("JSON = " + json);
		response.getWriter().write(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
