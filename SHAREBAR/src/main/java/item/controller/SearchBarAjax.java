package item.controller;

import java.io.IOException;
import java.util.ArrayList;
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

import item.model.ItemBean;
import item.model.ItemService;

@WebServlet("/item/searchBar.ajax")
public class SearchBarAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ItemService itemService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemService = (ItemService) context.getBean("itemService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// 接受資料
		String itemName = request.getParameter("itemName");
		
		System.out.println("itemName");

		// 驗證資料

		// 轉換資料

		// 呼叫Model
		ItemBean itemBean = new ItemBean();
		itemBean.setItem_name(itemName);
		List<ItemBean> result = itemService.selectByName(itemBean);
		List<ItemBean> jsonList = new ArrayList<>();
		for (ItemBean bean : result) {
			ItemBean jsonBean = new ItemBean();
			jsonBean.setItem_name(bean.getItem_name());
			jsonList.add(jsonBean);
		}
		String json = new Gson().toJson(jsonList);
		System.out.println("JSON = " + json);
		response.getWriter().write(json);

		// 根據Model的執行結果，顯示View
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
