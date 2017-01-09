package member.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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

@WebServlet("/secure/signup.controller")
@MultipartConfig
public class SignupServlet extends HttpServlet {
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
	
	//Activate program
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String,String> error = new HashMap<String,String>();
		request.setAttribute("error", error);
		String token = request.getParameter("token");
//		System.out.println("token= "+token);//token做確認
		MemberBean bean = memberService.findByToken(token);
		if(bean != null){
			if(bean.getCertification() == 0){
				boolean result = memberService.activateAccount(token);
				if(result){
					String path = request.getContextPath();
					response.sendRedirect(path+"/secure/activateSuccess.jsp");
					return;
				}else{
					String path = request.getContextPath();
					response.sendRedirect(path+"/secure/activateFail.jsp");
					return;
				}
			}else{
				String path = request.getContextPath();
				response.sendRedirect(path+"/index.jsp");
				return;
			}
		}
	}
	
	//sign up program
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		String member_email = request.getParameter("member_email");
		String password = request.getParameter("password");
		String member_nickname = request.getParameter("member_nickname");
		String member_description = request.getParameter("member_description");
		Part filePart = request.getPart("member_photo");
		String header = filePart.getHeader("Content-Disposition");
        String filename = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
        String fileExtend = getExtension(filename);
//        System.out.println("filename= "+filename);
        
		//驗證資料
		if(member_email == null || member_email.length() == 0){
			errors.put("id", "id is required.");
		}
		if(isValidEmailAddress(member_email)){
			errors.put("id", "This is not a valid email address");
		}
		if(password == null || password.length()==0){
			errors.put("password", "password is required.");
		}
		if(member_nickname==null || member_nickname.length()==0){
			errors.put("nickname", "nickname is required.");
		}
		if(member_description==null || member_description.length()==0){
			errors.put("description", "description is required.");
		}
		if(filename==null || filename.length()==0){
			errors.put("photo", "photo is required");
		}
		
		if(errors!=null && !errors.isEmpty()) {
			request.getRequestDispatcher(
					"/secure/signup.jsp").forward(request, response);
			return;
		}
		//轉換photo to byte[]
//	    InputStream fileContent = filePart.getInputStream();
//	    ByteArrayOutputStream ByteArrayOutputStream = null;
//		try {
//			BufferedInputStream bis = new BufferedInputStream(fileContent);
//			byte[] contents = new byte[8192];
//			int byteRead = 0;
//			ByteArrayOutputStream = new ByteArrayOutputStream(5000);
//			while((byteRead = bis.read(contents))!=-1){
//				ByteArrayOutputStream.write(contents);
//			}
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		//Service
		MemberBean bean = memberService.normalSignUp(member_email, getMD5(password), member_nickname, getMD5(member_email)+"."+fileExtend, member_description, last_name, first_name, country, city, getMD5(member_email));
		
		if(bean == null){
			errors.put("system", "sign up error, please try other email account");
			request.getRequestDispatcher("/secure/signup.jsp").forward(request, response);
			return;
		}else{
//			System.out.println(bean.getMember_email());
//			System.out.println(rootpath+getMD5(member_email)+"."+fileExtend);
			writeTo(getMD5(member_email)+"."+fileExtend, filePart, rootpath);
			sendActivatedMail(bean.getEmail());
			String path = request.getContextPath();
			response.sendRedirect(path+"/secure/signup_success.jsp");
			return;
		}
	}
	
	protected void sendActivatedMail(String email) {
		final String username = "sharebar2016@gmail.com";
		final String password = "EEit9008";

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("sharebar2016@gmail.com.tw"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("ShareBar Activated mail");
			try {
				String ip = (InetAddress.getLocalHost()).toString();
				ip = ip.substring(ip.indexOf("/")+1);
				message.setText(
						"Please click the link below to activate your account,\n\n http://"+ip+":8080/SHAREBAR/secure/signup.controller?token="
								+ getMD5(email));
				System.out.println("Please click the link below to activate your account,\n\n http://"+ip+":8080/SHAREBAR/secure/signup.controller?token="
						+ getMD5(email));
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Transport.send(message);
			System.out.println("Email send");
		} catch (MessagingException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	protected boolean isValidEmailAddress(String email) {
		   boolean result = true;
		   try {
		      InternetAddress emailAddr = new InternetAddress(email);
		      emailAddr.validate();
		   } catch (AddressException ex) {
		      result = false;
		   }
		   return result;
		}

}
