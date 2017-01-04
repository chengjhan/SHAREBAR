package administrator.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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

/**
 * Servlet implementation class ClearMemberBlockServlet
 */
@WebServlet("/administrator/ClearMemberBlockServlet")
public class ClearMemberBlockServlet extends HttpServlet {
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
		String temp = request.getParameter("member_no");
		if (temp == null || temp.length() == 0) {
			errors.put("member_no2", "memberNo is required");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}
		int member_no = 0;
		try {
			member_no = Integer.parseInt(temp);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			errors.put("member_no2", "please input a number");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}

		MemberBean bean = memberService.findById(member_no);
		
		if(bean==null){
			errors.put("member_no2", "can't find this number");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}
		
		bean.setBlockdate(null);
		boolean blockupdate = memberService.setBlockDate(bean);

		// 下面這兩行是為了更新權限後 直接撈出黑名單
		if (blockupdate) {
			List<MemberBean> memberBean = memberService.findBlockMember();
			request.setAttribute("members", memberBean);
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}else{
			errors.put("system", "data update fail");
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
