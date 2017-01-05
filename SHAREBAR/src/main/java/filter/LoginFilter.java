package filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.MemberBean;

public class LoginFilter implements Filter {

	public LoginFilter() {
		// TODO Auto-generated constructor stub
	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		if (request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
			System.out.println("start of loginFilter");
			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse resp = (HttpServletResponse) response;
//			req.getSession().setAttribute("target", target);
			// String servletPath = req.getServletPath();
			// System.out.println("111--->"+servletPath);

			if (checkLogin(req)) {
				System.out.println("222--->需要Login, 已經Login");
				chain.doFilter(request, response);
			} else {
				HttpSession session = req.getSession();
				session.setAttribute("target", req.getServletPath());
				System.out.println("333--->需要Login,尚未Login,ServletPath=" + req.getServletPath());
				boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
				if (ajax) {
					System.out.println("in filter");
					PrintWriter out = resp.getWriter();
					out.write("nonLogin");
					return;
				} else {
					String path = req.getContextPath();
					resp.sendRedirect(path+"/secure/login.jsp");
					return;
				}
			}

		} else {
			throw new ServletException("Request/Response Type Error");
		}
		// chain.doFilter(request, response);
		System.out.println("end of loginFilter");
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}

	private boolean checkLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberBean loginToken = (MemberBean) session.getAttribute("user");
		if (loginToken == null) {
			return false;
		} else {
			return true;
		}
	}

}
