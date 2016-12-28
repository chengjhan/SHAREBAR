package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;


//@WebFilter(filterName = "userUpdateFilter", urlPatterns = { "/*" })
public class UserBeanUpdateFilter implements Filter {

	@Autowired
	MemberService memberService;

	public UserBeanUpdateFilter() {
		// TODO Auto-generated constructor stub
	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		if (req instanceof HttpServletRequest && resp instanceof HttpServletResponse) {
			HttpServletRequest request = (HttpServletRequest) req;
			HttpServletResponse response = (HttpServletResponse) resp;
			System.out.println("start of userUpdateFilter");
			
			
			boolean sessionValid = true;
			try {
				HttpSession session = request.getSession(false);
				sessionValid = true;
			} catch (IllegalStateException ex) {
				sessionValid = false;
			}
			if (sessionValid) {
				MemberBean user = (MemberBean) request.getSession().getAttribute("user");
				if (user != null) {
					user = memberService.findById(user.getMember_no());
					request.getSession().setAttribute("user", user);
				}
			}
			chain.doFilter(req, resp);
			
			try{
				HttpSession session = request.getSession(false);
				sessionValid = true;
			}catch(IllegalStateException ex){
				sessionValid = false;
			}
			
			if (sessionValid) {
				MemberBean user = (MemberBean) request.getSession().getAttribute("user");
				if (user != null) {
					user = memberService.findById(user.getMember_no());
					request.getSession().setAttribute("user", user);
				}
			}
			
			System.out.println("end of userUpdateFilter");
		} else {
			throw new ServletException("Request/Response Type Error");
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		ServletContext application = fConfig.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
	}

}
