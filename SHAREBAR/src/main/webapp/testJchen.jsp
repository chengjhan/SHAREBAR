<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>test</title>
</head>
<body>
	<%@ page import="org.springframework.web.context.WebApplicationContext"%>
	<%@ page
		import="org.springframework.web.context.support.WebApplicationContextUtils"%>
	<%@ page import="item.model.*"%>
	<%@ page import="item.model.dao.*"%>
	<%@ page import="java.util.List"%>
	<%
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

		ItemService itemService = (ItemService) context.getBean("itemService");
		ItemBean selectByNameBean = new ItemBean();
// 		selectByNameBean.setItem_name("機");
// 		List<ItemBean> bean = itemService.selectByName(selectByNameBean);
		List<ItemBean> bean = itemService.selectByNew();
	%>
	<p><%=bean%></p>
</body>
</html>