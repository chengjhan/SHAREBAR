package followitem.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import followitem.model.FollowItemsBean;
import followitem.model.FollowItemsService;
import item.model.ItemBean;

@WebServlet("/showitems.controller")
public class ShowFollowItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private FollowItemsService followItemsService;
//	private ItemBean itembean;
//	private FollowItemsBean followitemsbean;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		followItemsService = (FollowItemsService) context.getBean("followItemsService");
	}
	
	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				request.setCharacterEncoding("UTF-8");
				response.setHeader("content-type", "text/html;charset=UTF-8");
		
				Map<String, String> errors = new HashMap<String,String>();
				request.setAttribute("errors", errors);
				
				//接收資料
				String userid = request.getParameter("userid");
				System.out.println(userid);
				
				//驗證資料
				
				try {
					if(userid.isEmpty()){
						errors.put("error", "no data");
					}
				} catch (Exception e) {
					System.out.println(e);
				}
				
				//轉換資料
				int i = Integer.parseInt(userid);
				System.out.println(i);
				

				//傳送資料jason
	
//				List<ItemBean> itembeans= followerItemsService.FollowerItemsDetail(i);
//				System.out.println(itembeans);
//				request.setAttribute("itembeans", itembeans);
				
				List<FollowItemsBean> followitembeans = followItemsService.followItemBeansDetail(Integer.valueOf(userid));
//				System.out.println(followeritembeans);
				
//				List<FollowerItemsBean> result = new ArrayList<FollowerItemsBean>();
//				for(FollowerItemsBean bean : followeritembeans){
//					FollowerItemsBean jsonBean = new FollowerItemsBean();
//					
//					ItemBean item = new ItemBean();
//					item.setItem_id(bean.getItemBean().getItem_id());
					
//					jsonBean.setItemBean(new ItemBean());
//					jsonBean.setMemberBean(bean.getMemberBean());
//					jsonBean.setStatus(bean.getStatus());
//					result.add(jsonBean);
//				}
				
//				String jsonfolloweritembean = new Gson().toJson(result);
//				System.out.println(jsonfolloweritembean);
//				response.getWriter().write(jsonfolloweritembean);
				
				
				request.setAttribute("followitembeans", followitembeans);
				request.getRequestDispatcher("/followeritems/followeritemlist.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	
	

}
