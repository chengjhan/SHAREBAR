package member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;

@WebServlet("/signin_fb.controller")
public class SignInFB extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Autowired
	MemberService memberService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setHeader("content-type", "text/html:charset=UTF-8");
		resp.setCharacterEncoding("UTF-8");
		Map<String,String> error = new HashMap<String,String>();
		req.setAttribute("error", error);
		String code = req.getParameter("code");
		if (code == null || code.equals("")) {
			// an error occurred, handle this
//			throw new RuntimeException("ERROR: Didn't get code parameter in callback.");
			error.put("facebook", "ERROR: Didn't get code parameter in callback.");
			req.getRequestDispatcher("/secure/signup.jsp").forward(req, resp);
			return;
		}

		String token = null;
		try {
			String g = "https://graph.facebook.com/oauth/access_token?client_id=903433963124082&redirect_uri="
					+ URLEncoder.encode("http://localhost:8080/TestFacebook/signin_fb.do", "UTF-8")
					+ "&client_secret=32bba2e768e578edfdb902f22e9f9445&code=" + code;
			URL u = new URL(g);
			URLConnection c = u.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
			String inputLine;
			StringBuffer b = new StringBuffer();
			while ((inputLine = in.readLine()) != null)
				b.append(inputLine + "\n");
			in.close();
			token = b.toString();
			System.out.println("token= " + token);
			if (token.startsWith("{")){
//				throw new Exception("error on requesting token: " + token + " with code: " + code);
				error.put("facebook", "error on requesting token: " + token + " with code: " + code);
				req.getRequestDispatcher("/secure/signup.jsp").forward(req, resp);
				return;
			}
		} catch (Exception e) {
			// an error occurred, handle this
//			throw new RuntimeException("ERROR: Access Token Invalid: " + token);
			error.put("facebook", "ERROR: Access Token Invalid");
			req.getRequestDispatcher("/secure/signup.jsp").forward(req, resp);
			return;
		}

		String graph = null;
		try {
			String g = "https://graph.facebook.com/me?fields=email,name&" + token;
			URL u = new URL(g);
			URLConnection c = u.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
			String inputLine;
			StringBuffer b = new StringBuffer();
			while ((inputLine = in.readLine()) != null)
				b.append(inputLine + "\n");
			in.close();
			graph = b.toString();
			 System.out.println("graph= " +graph);
		} catch (Exception e) {
			// an error occurred, handle this
			e.printStackTrace();
//			throw new RuntimeException("ERROR in getting FB graph data. " + e);
			error.put("facebook", "ERROR in getting FB graph data.");
			req.getRequestDispatcher("/secure/signup.jsp").forward(req, resp);
			return;
		}
		

		String facebookId;
		String email;
		String name;

		try {
			JSONObject json = new JSONObject(graph);
			if (json != null) {
				facebookId = json.getString("id").toString();
				email = json.getString("email").toString();
				name = json.getString("name").toString();
				System.out.println(json);
				String photo = null;
				try{
					String g = "https://graph.facebook.com/"+facebookId+"/picture?width=WIDTH&height=HEIGHT";
					URL u = new URL(g);
					URLConnection c = u.openConnection();
					BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
					String inputLine;
					StringBuffer b = new StringBuffer();
					while ((inputLine = in.readLine()) != null)
						b.append(inputLine + "\n");
					in.close();
					photo = b.toString();
					System.out.println("photo= "+photo);
				}catch(Exception e){
					error.put("facebook", "ERROR in getting FB graph photo data.");
					req.getRequestDispatcher("/secure/signup.jsp").forward(req, resp);
					return;
				}
			}
		} catch (JSONException e) {
			// an error occurred, handle this
			e.printStackTrace();
			System.out.println("can't get status from facebook");
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}