package member.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;

@WebServlet("/member/update.do")
@MultipartConfig
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	MemberService memberService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
	}
	
	private String getFilename(Part part) {
		String header = part.getHeader("Content-Disposition");
		String filename = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
		return filename;
	}
	
	private void writeTo(String filename, Part part, String rootpath) throws IOException, FileNotFoundException {
		InputStream in = part.getInputStream();
		OutputStream out = new FileOutputStream(rootpath + filename);
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
	
	public String getMD5(String input) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] messageDigest = md.digest(input.getBytes());
			BigInteger number = new BigInteger(1, messageDigest);
			String hashtext = number.toString(16);
			// Now we need to zero pad it if you actually want the full 32
			// chars.
			while (hashtext.length() < 32) {
				hashtext = "0" + hashtext;
			}
			return hashtext.toUpperCase();
		} catch (NoSuchAlgorithmException e) {
			System.out.println("請檢查使用的演算法是否有誤");
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		String rootpath = request.getServletContext().getRealPath("/profileImages/");//get web app root directory
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String country = request.getParameter("country");
		String city = request.getParameter("city");
		String member_nickname = request.getParameter("member_nickname");
		String member_description = request.getParameter("member_description");
//		Part filePart = request.getPart("member_photo");
//		String filename = "";
//		try{
//        filename = getFilename(filePart);
//		}catch(NullPointerException e){System.out.println("can't read file");}
//        String fileExtend = getExtension(filename);
        
		if(member_nickname==null || member_nickname.length()==0){
			errors.put("nickname", "nickname is required.");
		}
		if(member_description==null || member_description.length()==0){
			errors.put("description", "description is required.");
		}
//		if(filename==null || filename.length()==0){
//			errors.put("photo", "photo is required");
//		}
		
		if(errors!=null && !errors.isEmpty()) {
			request.getRequestDispatcher(
					"/member/changeInfo.jsp").forward(request, response);
			return;
		}
		
		MemberBean userBean = (MemberBean)request.getSession().getAttribute("user");
		userBean.setFirst_name(first_name);
		userBean.setLast_name(last_name);
		userBean.setCountry(country);
		userBean.setCity(city);
		userBean.setNickname(member_nickname);
		userBean.setDescription(member_description);
//		userBean.setPhoto(getMD5(userBean.getEmail())+"."+fileExtend);
		
		
		userBean = memberService.update(userBean);
		if(userBean != null){
//			writeTo(getMD5(userBean.getEmail())+"."+fileExtend, filePart, rootpath);
			String path = request.getContextPath();
			response.sendRedirect(path+"/member/userProfile.jsp");
		}else{
			errors.put("system", "update errors");
			request.getRequestDispatcher("/member/changeInfo.jsp").forward(request, response);
			return;
		}
	}

}
