package administrator.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/administrator/SelectByMemberNameServlet")
public class SelectByMemberNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Autowired
	MemberService memberService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String, String> errors = new HashMap<String, String>();
		
		request.setAttribute("errors", errors);
		String member_email = request.getParameter("member_email");
		if (member_email == null || member_email.length() == 0) {
			errors.put("member_email", "email is required");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}

		// List<MemberBean> memberBean =
		// reportDAO.selectByMemberName(String.valueOf(member_email));
		MemberBean memberBean = memberService.findByEmail(member_email);
		if (memberBean != null) {
			request.setAttribute("member", memberBean);

			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}else{
			errors.put("system","can't find the member");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
