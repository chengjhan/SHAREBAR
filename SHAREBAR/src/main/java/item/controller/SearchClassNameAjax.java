package item.controller;

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

import item.model.ItemBean;
import item.model.ItemService;

@WebServlet("/item/searchClassName.ajax")
public class SearchClassNameAjax extends HttpServlet {

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
		String tempClass_id = request.getParameter("class_id");
		String temp_swLat = request.getParameter("swLat");
		String temp_swLng = request.getParameter("swLng");
		String temp_neLat = request.getParameter("neLat");
		String temp_neLng = request.getParameter("neLng");

		// 驗證資料

		// 轉換資料
		int class_id = 0;
		if (tempClass_id != null && tempClass_id.length() != 0) {
			try {
				class_id = Integer.parseInt(tempClass_id);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double swLat = 0;
		if (temp_swLat != null && temp_swLat.length() != 0) {
			try {
				swLat = Double.parseDouble(temp_swLat);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double swLng = 0;
		if (temp_swLng != null && temp_swLng.length() != 0) {
			try {
				swLng = Double.parseDouble(temp_swLng);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double neLat = 0;
		if (temp_neLat != null && temp_neLat.length() != 0) {
			try {
				neLat = Double.parseDouble(temp_neLat);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double neLng = 0;
		if (temp_neLng != null && temp_neLng.length() != 0) {
			try {
				neLng = Double.parseDouble(temp_neLng);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 呼叫Model
		GsonBuilder builder = new GsonBuilder();
		builder.excludeFieldsWithoutExposeAnnotation();
		Gson gson = builder.create();
		List<ItemBean> result = itemService.selectByBoundsByClass(swLat, swLng, neLat, neLng, class_id);
		String json = gson.toJson(result);
		System.out.println("JSON = " + json);
		response.getWriter().write(json);

		// 根據Model的執行結果，顯示View
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
