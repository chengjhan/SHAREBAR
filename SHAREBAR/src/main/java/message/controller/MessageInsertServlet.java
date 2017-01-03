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
import member.model.MemberService;
import message.model.MessageContextBean;
import message.model.MessageContextService;
import message.model.RequestListService;

@WebServlet("/messageInsert.ajax")
public class MessageInsertServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private MessageContextService messageContextService;
	
	@Override	
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
		itemService = (ItemService) context.getBean("itemService");
		messageContextService = (MessageContextService) context.getBean("messageContextService");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String content_str = request.getParameter("content");		
		int item_id = Integer.valueOf(request.getParameter("item"));		
		int speaker_id = Integer.valueOf(request.getParameter("speaker"));		
		int listener_id = Integer.valueOf(request.getParameter("listener"));
						
		MessageContextBean bean = new MessageContextBean();
		bean.setItemBean(itemService.selectById(item_id));		
		bean.setMemberBean_speaker(memberService.findById(speaker_id));
		bean.setMemberBean_listener(memberService.findById(listener_id));
		bean.setTime( new java.util.Date() );
		bean.setContext(content_str);
		messageContextService.insert(bean);
		System.out.println("系統：寫入資料庫:" + content_str);
				
	}

}
