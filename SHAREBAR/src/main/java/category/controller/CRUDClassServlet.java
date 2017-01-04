package category.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
public class CRUDClassServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ClassService classService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		classService = (ClassService) context.getBean("classService");
	}

	private String getFilename(Part part) {
		String header = part.getHeader("Content-Disposition");
		String filename = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
		return filename;
	}

	public String getExtension(String filename) {
		int startIndex = filename.lastIndexOf(46) + 1;
		int endIndex = filename.length();
		return filename.substring(startIndex, endIndex);
	}

	private void writeTo(String filename, Part part, String path) throws IOException, FileNotFoundException {
		InputStream in = part.getInputStream();
		System.out.println(path);
		OutputStream out = new FileOutputStream(path + filename);
		byte[] buffer = new byte[1024];
		int length = -1;
		while ((length = in.read(buffer)) != -1) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.close();
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
		String class_action = request.getParameter("class_action");
		String tempClass_id = request.getParameter("class_id");
		String class_name = request.getParameter("class_name");
		Part image = request.getPart("image");
		String imageFilename = getFilename(image);
		Part icon = request.getPart("icon");
		String iconFilename = getFilename(icon);
		Part icon_after = request.getPart("icon_after");
		String icon_afterFilename = getFilename(icon_after);

		System.out.println(class_action);
		System.out.println(class_name);

		// 驗證資料
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		if ("修改".equals(class_action) || "刪除".equals(class_action)) {
			if (tempClass_id == null || tempClass_id.length() == 0) {
				errors.put("class_name", "必填");
			}
		}
		if (class_name == null || class_name.length() == 0) {
			errors.put("class_name", "必填");
		}
		if ("修改".equals(class_action)) {
			if (imageFilename == null) {
				errors.put("image", "必填");
			}
			if (iconFilename == null) {
				errors.put("icon", "必填");
			}
			if (icon_afterFilename == null) {
				errors.put("icon_after", "必填");
			}
		}
		if (errors != null && !errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
			rd.forward(request, response);
			return;
		}

		// 轉換資料
		int class_id = 0;
		if (tempClass_id != null && tempClass_id.length() != 0) {
			try {
				class_id = Integer.parseInt(tempClass_id);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		// image --> byte[] --> 資料庫
//		InputStream inputStream = image.getInputStream();
//		ByteArrayOutputStream byteArrayOutputStream = null;
//		try {
//			BufferedInputStream bis = new BufferedInputStream(inputStream);
//			byte[] contents = new byte[8192];
//			byteArrayOutputStream = new ByteArrayOutputStream(5000);
//			while (bis.read(contents) != -1) {
//				byteArrayOutputStream.write(contents);
//			}
//		} catch (IOException e) {
//			e.printStackTrace();
//		}

		// 呼叫Model
		String path_image = request.getServletContext().getRealPath("/category-image/");
		String path_icon = request.getServletContext().getRealPath("/category-icon/");

		String newImageFilename = class_name + "." + getExtension(iconFilename);
		writeTo(newImageFilename, image, path_image);

		String newIconFilename = class_name + "." + getExtension(iconFilename);
		writeTo(newIconFilename, icon, path_icon);

		String newIcon_afterFilename = class_name + "a." + getExtension(icon_afterFilename);
		writeTo(newIcon_afterFilename, icon_after, path_icon);

		ClassBean bean = new ClassBean();
		bean.setClass_id(class_id);
		bean.setClass_name(class_name);
		// bean.setImage(byteArrayOutputStream.toByteArray());
		bean.setImage(newImageFilename);
		bean.setIcon(newIconFilename);
		bean.setIcon_after(newIcon_afterFilename);
		System.out.println(bean);

		// 根據Model的執行結果，顯示View
		if ("新增".equals(class_action)) {
			ClassBean result = classService.insert(bean);
			if (result != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
				rd.forward(request, response);
				return;
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
				rd.forward(request, response);
				return;
			}

		} else if ("修改".equals(class_action)) {
			ClassBean result = classService.update(bean);
			if (result != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
				rd.forward(request, response);
				return;
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
				rd.forward(request, response);
				return;
			}
		} else if ("刪除".equals(class_action)) {
			Boolean result = classService.delete(bean);
			if (result) {
				RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
				rd.forward(request, response);
				return;
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("/category/CRUDClass.jsp");
				rd.forward(request, response);
				return;
			}
		}
	}

}
