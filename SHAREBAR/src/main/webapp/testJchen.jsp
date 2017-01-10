<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<%@ page import="member.model.MemberBean"%>
	<%@ page import="java.util.List"%>
	<%@ page import="org.json.JSONArray"%>
	<%@ page import="org.json.JSONObject"%>
	<%@ page import="category.model.*" %>
<%
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

		ItemService itemService = (ItemService) context.getBean("itemService");
		ClassService classService = (ClassService) context.getBean("classService");
		ItemBean selectByNameBean = new ItemBean();
		// 		selectByNameBean.setItem_name("機");
		// 		List<ItemBean> bean = itemService.selectByName(selectByNameBean);
		List<ClassBean> list = classService.selectByRandom();
		for(ClassBean bean : list){
			out.print(bean.getClass_id()+"    ");
		}


%>
</body>
</html>