package item.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import image.model.ImageBean;
import image.model.ImageService;
import item.model.ItemBean;
import item.model.ItemService;

@WebServlet("/item/update.controller")
@MultipartConfig
public class UpdateItemServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ItemService itemService;
	private ImageService imageService;
	private ClassService classService;
	private SimpleDateFormat simpleDateFormat;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemService = (ItemService) context.getBean("itemService");
		imageService = (ImageService) context.getBean("imageService");
		classService = (ClassService) context.getBean("classService");
		simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	}

	private String getFilename(Part part) {
		String header = part.getHeader("Content-Disposition");
		String filename = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
		return filename;
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

	public String getExtension(String filename) {
		int startIndex = filename.lastIndexOf(46) + 1;
		int endIndex = filename.length();
		return filename.substring(startIndex, endIndex);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String temp0 = request.getParameter("item_id");
		String item_name = request.getParameter("item_name");
		String class_name = request.getParameter("class_name");
		String location = request.getParameter("location");
		String item_description = request.getParameter("item_description");
		String temp1 = request.getParameter("latitude");
		String temp2 = request.getParameter("longitude");
		String temp3 = request.getParameter("end_date");

		String temp_image_id1 = request.getParameter("image_id1");
		Part image1 = request.getPart("image_photo1");
		String image1Filename = getFilename(image1);
		String temp_image_id2 = request.getParameter("image_id2");
		Part image2 = request.getPart("image_photo2");
		String image2Filename = getFilename(image2);
		String temp_image_id3 = request.getParameter("image_id3");
		Part image3 = request.getPart("image_photo3");
		String image3Filename = getFilename(image3);
		String temp_image_id4 = request.getParameter("image_id4");
		Part image4 = request.getPart("image_photo4");
		String image4Filename = getFilename(image4);

		System.out.println(temp0);
		System.out.println(item_name);
		System.out.println(class_name);
		System.out.println(location);
		System.out.println(item_description);
		System.out.println(temp1);
		System.out.println(temp2);
		System.out.println(temp3);

		System.out.println(temp_image_id1);
		System.out.println(image1Filename);
		System.out.println(temp_image_id2);
		System.out.println(image2Filename);
		System.out.println(temp_image_id3);
		System.out.println(image3Filename);
		System.out.println(temp_image_id4);
		System.out.println(image4Filename);

		// 驗證資料
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		if (item_name == null || item_name.length() == 0) {
			errors.put("item_name", "必填");
		}
		if (location == null || location.length() == 0) {
			errors.put("location", "必填");
		}
		if (image1Filename == null || image1Filename.length() == 0) {
			errors.put("image1", "必填");
		}
		if (errors != null && !errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("/item/UpdateItem.jsp");
			rd.forward(request, response);
			return;
		}

		// 轉換資料
		int item_id = 0;
		if (temp0 != null && temp0.length() != 0) {
			try {
				item_id = Integer.parseInt(temp0);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double latitude = 0;
		if (temp1 != null && temp1.length() != 0) {
			try {
				latitude = Double.parseDouble(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double longitude = 0;
		if (temp2 != null && temp2.length() != 0) {
			try {
				longitude = Double.parseDouble(temp2);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		java.util.Date end_date = null;
		if (temp3 != null && temp3.length() != 0) {
			try {
				end_date = simpleDateFormat.parse(temp3);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		int image_id1 = 0;
		if (temp_image_id1 != null && temp_image_id1.length() != 0) {
			try {
				image_id1 = Integer.parseInt(temp_image_id1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		int image_id2 = 0;
		if (temp_image_id2 != null && temp_image_id2.length() != 0) {
			try {
				image_id2 = Integer.parseInt(temp_image_id2);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		int image_id3 = 0;
		if (temp_image_id3 != null && temp_image_id3.length() != 0) {
			try {
				image_id3 = Integer.parseInt(temp_image_id3);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		int image_id4 = 0;
		if (temp_image_id4 != null && temp_image_id4.length() != 0) {
			try {
				image_id4 = Integer.parseInt(temp_image_id4);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 呼叫Model
		ItemBean itemBean = new ItemBean();
		itemBean.setItem_id(item_id);
		itemBean.setItem_name(item_name);
		itemBean.setItem_description(item_description);
		itemBean.setMember_id("aaa@aaa.com");
		itemBean.setLocation(location);
		ClassBean classBean = new ClassBean();
		classBean.setClass_name(class_name);
		itemBean.setClassBean(classService.selectByName(classBean));
		itemBean.setLatitude(latitude);
		itemBean.setLongitude(longitude);
		itemBean.setEnd_date(end_date);
		ItemBean result = itemService.update(itemBean);

		String path = request.getServletContext().getRealPath("/item-image/");
		String newImage1Filename = result.getItem_id() + "_1." + getExtension(image1Filename);
		writeTo(newImage1Filename, image1, path);
		ImageBean imageBean1 = new ImageBean();
		imageBean1.setImage_id(image_id1);
		imageBean1.setItemBean(itemBean);
		imageBean1.setImage_photo(newImage1Filename);
		ImageBean result1 = imageService.update(imageBean1);
		if (image2Filename != null && image2Filename.length() != 0) {
			String newImage2Filename = result.getItem_id() + "_2." + getExtension(image2Filename);
			writeTo(newImage2Filename, image2, path);
			ImageBean imageBean2 = new ImageBean();
			imageBean2.setImage_id(image_id2);
			imageBean2.setItemBean(itemBean);
			imageBean2.setImage_photo(newImage2Filename);
			imageService.update(imageBean2);
		}
		if (image3Filename != null && image3Filename.length() != 0) {
			String newImage3Filename = result.getItem_id() + "_3." + getExtension(image3Filename);
			writeTo(newImage3Filename, image3, path);
			ImageBean imageBean3 = new ImageBean();
			imageBean3.setImage_id(image_id3);
			imageBean3.setItemBean(itemBean);
			imageBean3.setImage_photo(newImage3Filename);
			imageService.update(imageBean3);
		}
		if (image4Filename != null && image4Filename.length() != 0) {
			String newImage4Filename = result.getItem_id() + "_4." + getExtension(image4Filename);
			writeTo(newImage4Filename, image4, path);
			ImageBean imageBean4 = new ImageBean();
			imageBean4.setImage_id(image_id4);
			imageBean4.setItemBean(itemBean);
			imageBean4.setImage_photo(newImage4Filename);
			imageService.update(imageBean4);
		}

		// 根據Model的執行結果，顯示View
		if (result != null && result1 != null) {
			RequestDispatcher rd = request.getRequestDispatcher("/item/UpdateItemSuccess.jsp");
			rd.forward(request, response);
			return;
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("/item/UpdateItem.jsp");
			rd.forward(request, response);
			return;
		}
	}

}
