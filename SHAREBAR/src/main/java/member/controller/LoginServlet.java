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
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;

@WebServlet("/secure/login.controller")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	MemberService memberService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
	}

	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		if (email == null || email.length() == 0) {
			errors.put("email", "please input your email");
		}
		if (password == null || password.length() == 0) {
			errors.put("password", "please input your password");
		}
		if (!errors.isEmpty()) {
			request.getRequestDispatcher("/secure/login.jsp").forward(request, response);
			return;
		}

		MemberBean bean = memberService.login(email, getMD5(password));
		if (bean == null) {
			errors.put("system", "wrong email or password.");
			request.getRequestDispatcher("/secure/login.jsp").forward(request, response);
			return;
		} else {
			if (bean.getBlockdate() != null) {
				if (new java.util.Date().after(bean.getBlockdate())) {
					if (bean.getCertification() == 1) {
						HttpSession session = request.getSession();
						session.setAttribute("user", bean);
						String path = request.getContextPath();
						String from = (String) request.getSession().getAttribute("from");
						String target = (String) request.getSession().getAttribute("target");
						if (from != null) {
							from = from.substring(from.lastIndexOf("SHAREBAR/") + 9);
							response.sendRedirect(path + "/" + from);
						} else {
							response.sendRedirect(path + "/index.jsp");
						}

						return;
					} else {
						errors.put("system", "you nead to activate your account.");
						request.getRequestDispatcher("/secure/login.jsp").forward(request, response);
						return;
					}
				}
			} else {
				if (bean.getCertification() == 1) {
					HttpSession session = request.getSession();
					session.setAttribute("user", bean);
					String path = request.getContextPath();
					String from = (String) request.getSession().getAttribute("from");
					String target = (String) request.getSession().getAttribute("target");

					if (from != null) {
						from = from.substring(from.lastIndexOf("SHAREBAR/") + 9);
						response.sendRedirect(path + "/" + from);
					} else {
						response.sendRedirect(path + "/index.jsp");
					}

					return;
				} else {
					errors.put("system", "you nead to activate your account.");
					request.getRequestDispatcher("/secure/login.jsp").forward(request, response);
					return;
				}
			}
		}

	}

	protected String getMD5(String input) {
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

}
