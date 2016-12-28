package category.controller;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import category.model.ClassBean;
import category.model.ClassService;

@WebServlet("/category/crud.controller")
@MultipartConfig
public class ClassServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ClassService classService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		classService = (ClassService) context.getBean("classService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// 接受資料
		String class_name = request.getParameter("class_name");
		Part image = request.getPart("image");
		String selector = request.getParameter("selector");

		System.out.println(class_name);
		System.out.println(selector);

		// 驗證資料
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		if (class_name == null || class_name.length() == 0) {
			errors.put("class_name", "必填");
		}
		if (image == null) {
			errors.put("image", "必填");
		}
		if (errors != null && !errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("/category/InsertUpdateClass.jsp");
			rd.forward(request, response);
			return;
		}

		// 轉換資料
		InputStream inputStream = image.getInputStream();
		ByteArrayOutputStream byteArrayOutputStream = null;
		try {
			BufferedInputStream bis = new BufferedInputStream(inputStream);
			byte[] contents = new byte[8192];
			byteArrayOutputStream = new ByteArrayOutputStream(5000);
			while (bis.read(contents) != -1) {
				byteArrayOutputStream.write(contents);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 呼叫Model
		ClassBean bean = new ClassBean();
		bean.setClass_name(class_name);
		bean.setImage(byteArrayOutputStream.toByteArray());
		System.out.println(bean);
		ClassBean result = classService.insert(bean);

		// 根據Model的執行結果，顯示View
		if (result != null) {
			RequestDispatcher rd = request.getRequestDispatcher("/category/DisplayClass.jsp");
			rd.forward(request, response);
			return;
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/category/InsertUpdateClass.jsp");
			rd.forward(request, response);
			return;
		}
	}

}
