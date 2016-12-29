<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#profilePhoto {
	width: 100px;
	height: 100px;
}
</style>
</head>
<body>
	<%@ page import="member.model.MemberBean"%>
	<%@ page import="member.model.MemberService"%>
	<%@ page import="relationship.model.RelationshipBean"%>
	<%@ page import="relationship.model.RelationshipService" %>
	<%@ page import="java.util.*"%>
	<%@ page import="org.springframework.web.context.WebApplicationContext"%>
	<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
	<%
		WebApplicationContext context = (WebApplicationContext) WebApplicationContextUtils
				.getWebApplicationContext(application);
		MemberService ms = (MemberService) context.getBean("memberService");
		RelationshipService rs = (RelationshipService) context.getBean("relationshipService");
		MemberBean user = ms.login("newianlin@gmail.com", "asdfjkl;");
		List<RelationshipBean> rbl = rs.findFollow(user);
		RelationshipBean temp = null;
		if(rbl.isEmpty()){
			out.println("list is empty");
		}else{
			out.println("list is not empty");
			for(int i=0; i<rbl.size(); i++){
				temp = rbl.get(i);
				out.println(temp.getMember_follow().getMember_no()+" "+temp.getRelation()+" "+temp.getMember_followed().getMember_no()+";");
			}
		}
// 		out.println(service.normalSignUp("ccc@gmail.com", "cccccccc", "CCC", null, "I am CCC"));
// 		MemberBean bean = ms.login("aaa@gmail.com", "aaaaaaaa");
// 		if (bean != null) {
// 			out.println("bean= " + bean);
// 			out.println("member_no: " + bean.getMember_no() + " has been followed by");
// 			for (RelationshipBean rb : bean.getMember_followed_rel()) {
// 				out.println(rb.getMember_follow().getMember_no());
// 			}
// 		}

		// out.println("bean="+bean);
		// out.println(bean.getMember_photo());
		// if(bean != null){
		// String photo = Base64.getEncoder().encodeToString(bean.getMember_photo());
		// out.print("<img id='profilePhoto' src='data:image/jpg;base64,"+photo+"'/>");
		// }
// 		bean = service.normalSignUp("ccc@gmail.com", "ccc", "CCC", "aaa".getBytes(), "Hello! I am CCC!");
		// out.println("bean= "+bean);

		// out.println(service.activateAccount("D39A7ABDA3C7A690A33EC92D9D0D0DE8"));
	%>
</body>
</html>
