package administrator.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

@WebServlet("/administrator/UpdateMemberBlockServlet")
public class UpdateMemberBlockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// private ReportDAO reportDAO;
	@Autowired
	MemberService memberService;
	SimpleDateFormat simpleDateFormat;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		memberService = (MemberService) context.getBean("memberService");
		simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String,String> errors = new HashMap<String,String>();
		String temp1 = request.getParameter("member_no");
		String temp = request.getParameter("member_block");
		request.setAttribute("errors", errors);
		if (temp1 == null || temp1.length() == 0) {
			errors.put("member_no", "memberNo is required");
		}
		if (temp == null || temp.length() == 0) {
			errors.put("member_block", "block date is required");
		}
		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}
		int member_no = 0;
		try {
			member_no = Integer.parseInt(temp1);
		} catch (NumberFormatException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			errors.put("member_no", "please input a number");
		} catch(NullPointerException e2){
			errors.put("member_no", "can't find this number");
		}
		
		java.util.Date blockdate = null;
		try {
			blockdate = simpleDateFormat.parse(temp);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("date format wrong");
			errors.put("member_block", "please input date format as yyyy-MM-dd");
		}

		if (!errors.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}
		
		
		MemberBean bean = memberService.findById(member_no);
		if(bean==null){
			errors.put("member_no", "can't find this number");
			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}
		bean.setBlockdate(blockdate);
		boolean blockupdate = memberService.setBlockDate(bean);
		// 下面這兩行是為了更新權限後 直接撈出黑名單
		// List<MemberBean> memberBean = reportDAO.selectBlockMember();
		if (blockupdate) {
			List<MemberBean> memberBean = (List<MemberBean>) memberService.findBlockMember();
			request.setAttribute("members", memberBean);

			RequestDispatcher rd = request.getRequestDispatcher("gm_view01.jsp");
			rd.forward(request, response);
			return;
		}else{
			errors.put("system", "system update wrong");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}
