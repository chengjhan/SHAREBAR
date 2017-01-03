package member.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.URL;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collections;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import member.model.MemberBean;
import member.model.MemberService;

@WebServlet("/secure/tokensignin")
public class GSignServlet extends HttpServlet {

	public void saveImage(String imageUrl, String destinationFile) throws IOException {
		URL url = new URL(imageUrl);
		InputStream is = url.openStream();
		OutputStream os = new FileOutputStream(destinationFile);

		byte[] b = new byte[2048];
		int length;

		while ((length = is.read(b)) != -1) {
			os.write(b, 0, length);
		}

		is.close();
		os.close();
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

	private static final long serialVersionUID = 1L;
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();

	@Autowired
	MemberService memberService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
	}

	public GSignServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String rootpath = request.getServletContext().getRealPath("/profileImages/");
		// GoogleIdTokenVerifier verifier = new
		// GoogleIdTokenVerifier.Builder(HTTP_TRANSPORT, JSON_FACTORY)
		// .setAudience(Collections
		// .singletonList("307771007729-rmscbeafik1eh81eo2v9rtv4bb5n1tml.apps.googleusercontent.com"))
		// // Or, if multiple clients access the backend:
		// // .setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2,
		// // CLIENT_ID_3))
		// .build();

		// (Receive idTokenString by HTTPS POST)
		String idTokenString = request.getParameter("id_token");
		String userId = request.getParameter("ID");
		String name = request.getParameter("Name");
		String pictureUrl = request.getParameter("Image URL");
		String familyName = request.getParameter("Family Name");
		String givenName = request.getParameter("Given Name");
		String email = request.getParameter("Email");
		System.out.println("id_token:" + idTokenString);

		MemberBean mb1 = memberService.findByG(userId);
		if (mb1 != null) {
			System.out.println("mb1!=null");
		} else {
			System.out.println("mb1==null");
		}
		if (mb1 != null) {
			if (mb1.getFacebook() != null) {
				if (mb1.getFacebook().equals(userId)) {
					System.out.println("login...");
					request.getSession().setAttribute("user", mb1);
					out.write("GLoginSuccess");
					return;
				}else{
					System.out.println("system error");
					out.write("GLoginfail");
					return;
				}
			} else if (mb1.getFacebook() == null) {
				System.out.println("login fail, account exist...");
				out.write("AccountExist");
				return;
			}
		} else {
			MemberBean result = memberService.GSignUp(userId, email, name, givenName, familyName,
					getMD5(email) + "." + pictureUrl.substring(pictureUrl.lastIndexOf(".")), getMD5("0000"));
			if (result != null) {
				saveImage(pictureUrl,
						rootpath + getMD5(email) + "." + pictureUrl.substring(pictureUrl.lastIndexOf(".")));
				request.getSession().setAttribute("user", result);
				System.out.println("sign and login...");
				out.write("GSignAndLoginSuccess");
				return;
			}else{
				System.out.println("system error");
				out.write("GLoginfail");
				return;
			}
		}

		// GoogleIdToken idToken = null;
		// try {
		// idToken = verifier.verify(idTokenString);
		// } catch (GeneralSecurityException e) {
		// e.printStackTrace();
		// }
		// if (idToken != null) {
		// Payload payload = idToken.getPayload();
		//
		// // Print user identifier
		// String userId = payload.getSubject();
		// System.out.println("User ID: " + userId);
		//
		// // Get profile information from payload
		// String email = payload.getEmail();
		// boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
		// String name = (String) payload.get("name");
		// String pictureUrl = (String) payload.get("picture");
		// String locale = (String) payload.get("locale");
		// String familyName = (String) payload.get("family_name");
		// String givenName = (String) payload.get("given_name");
		//
		// // Use or store profile information
		// // ...
		// System.out.println("payload= " + payload);
		// System.out.println("email= " + email);
		// System.out.println("emailVerified= " + emailVerified);
		// System.out.println("name= " + name);
		// System.out.println("pictureUrl= " + pictureUrl);
		// System.out.println("local= " + locale);
		// System.out.println("familyName= " + familyName);
		// System.out.println("givenName= " + givenName);
		//
		// MemberBean mb1 = memberService.findByEmail(email);
		// if(mb1!=null){
		// System.out.println("mb1!=null");
		// }else{
		// System.out.println("mb1==null");
		// }
		// if(mb1!=null){
		// if(mb1.getFacebook().equals(userId)){
		// System.out.println("login...");
		// request.getSession().setAttribute("user", mb1);
		// out.write("GLoginSuccess");
		// return;
		// }else if(mb1.getFacebook()==null){
		// System.out.println("login fail, account exist...");
		// out.write("AccountExist");
		// return;
		// }
		// }else{
		// MemberBean result = memberService.GSignUp(userId, email, givenName,
		// familyName,
		// getMD5(email)+"."+pictureUrl.substring(pictureUrl.lastIndexOf(".")));
		// if(result!=null){
		// saveImage(pictureUrl,
		// rootpath+getMD5(email)+"."+pictureUrl.substring(pictureUrl.lastIndexOf(".")));
		// request.getSession().setAttribute("user", result);
		// System.out.println("sign and login...");
		// out.write("GSignAndLoginSuccess");
		// return;
		// }
		// }
		//
		//
		// } else {
		// System.out.println("Invalid ID token.");
		// out.write("InvalidIdToken");
		// return;
		// }
	}

}
