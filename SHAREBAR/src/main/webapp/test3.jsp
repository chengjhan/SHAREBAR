<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@page import="message.model.*" %>
<%@page import="message.model.dao.*" %>
<%@page import="member.model.*" %>
<%@page import="member.model.dao.*" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>connection</title>
</head>
<body>
	<%
		WebApplicationContext context = (WebApplicationContext) WebApplicationContextUtils.getWebApplicationContext(application);
				
		MessageContextService messageContextService = (MessageContextService)context.getBean("messageContextService");
// 		List<MessageContextBean> group = messageContextService.select(2,1);
// 		out.println("group = " + group +"<br>");
		
// 		RequestListService requestListService = (RequestListService)context.getBean("requestListService");
// 		String status = requestListService.askConsent(2,1);
// 		out.println("status = " + status +"<br>");
		
		MemberBean bean = new MemberBean();
// 		bean.setMember_no(1);
		
		List<Object[]> results = messageContextService.mailForShare(1);
		out.println(results);
		
		int unReaded = messageContextService.mailUnreaded(9);
		out.println(unReaded);
	%>
</body>
</html>