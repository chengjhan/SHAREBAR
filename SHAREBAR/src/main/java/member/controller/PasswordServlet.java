package member.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;


@WebServlet("/member/changePassword.do")
public class PasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	MemberService memberService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
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
       


    public PasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		String oldPassword = request.getParameter("old_password");
		String newPassword = request.getParameter("new_password");
		
		if(oldPassword == null || oldPassword.length() == 0){
			errors.put("oldpassword", "this is required");
		}
		if(newPassword == null || newPassword.length() == 0){
			errors.put("newpassword", "this is required");
		}
		if(!errors.isEmpty()){
			request.getRequestDispatcher(
					"/member/changePassword.jsp").forward(request, response);
			return;
		}
		
		MemberBean userBean = (MemberBean)request.getSession().getAttribute("user");
		MemberBean bean = memberService.login(userBean.getEmail(), getMD5(oldPassword));
		if(bean == null){
			errors.put("oldpassword", "wrong password");
			request.getRequestDispatcher(
					"/member/changePassword.jsp").forward(request, response);
			return;
		}
		bean.setPassword(getMD5(newPassword));
		bean = memberService.update(bean);
		if(bean == null){
			errors.put("system", "system wrong, can't update password");
			request.getRequestDispatcher(
					"/member/changePassword.jsp").forward(request, response);
			return;
		}else{
			String path = request.getContextPath();
			response.sendRedirect(path+"/member/userProfile.jsp");
			return;
		}
		
		
	}

}
