package item.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import item.model.ItemBean;
import item.model.ItemService;

@WebServlet("/item/display.controller")
public class DisplayItemServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ItemService itemService;

	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemService = (ItemService) context.getBean("itemService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 接受資料
		String member_id = request.getParameter("member_id");

		System.out.println(member_id);

		// 驗證資料

		// 轉換資料

		// 呼叫Model
		ItemBean itemBean = new ItemBean();
		itemBean.setMember_id(member_id);
		List<ItemBean> result = itemService.selectByMember(itemBean);
		System.out.println(result);

		// 根據Model的執行結果，顯示View
		if (result != null) {
			request.setAttribute("itemBean", result);
			RequestDispatcher rd = request.getRequestDispatcher("/item/DisplayItem.jsp");
			rd.forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
