package filter;

import java.io.IOException;
import java.util.List;

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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import member.model.MemberBean;
import member.model.MemberService;
import relationship.model.RelationshipBean;
import relationship.model.RelationshipService;

//@WebFilter(filterName = "showMemberFilter", urlPatterns = { "/profile.controller?*fdsfadfdsf" })
public class ShowMemberFilter implements Filter {

	@Autowired
	MemberService memberService;

	@Autowired
	RelationshipService relationshipService;

	public ShowMemberFilter() {
		// TODO Auto-generated constructor stub
	}

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		System.out.println("start of showMemberFilter");
		chain.doFilter(request, response);
		MemberBean member = (MemberBean) request.getAttribute("member");
		List<RelationshipBean> followList = relationshipService.findFollow(member);
		if (!followList.isEmpty()) {
			request.setAttribute("memberFollow", followList);
		}
		System.out.println("end of showMemberFilter");
	}

	public void init(FilterConfig fConfig) throws ServletException {
		ServletContext application = fConfig.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
		relationshipService = (RelationshipService) context.getBean("relationshipService");
	}

}
