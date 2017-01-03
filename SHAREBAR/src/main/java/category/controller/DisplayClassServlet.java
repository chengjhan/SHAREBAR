package category.controller;

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

import category.model.ClassBean;
import category.model.ClassService;

@WebServlet("/category/display.controller")
public class DisplayClassServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ClassService classService;

	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		classService = (ClassService) context.getBean("classService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 接受資料
		
		// 驗證資料
		
		// 轉換資料
		
		// 呼叫Model
		List<ClassBean> result = classService.select(null);

		// 根據Model的執行結果，顯示View
		if (result != null) {
			request.setAttribute("classBean", result);
			RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
			rd.forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
