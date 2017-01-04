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
	<%
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

		ItemService itemService = (ItemService) context.getBean("itemService");
		ItemBean selectByNameBean = new ItemBean();
		// 		selectByNameBean.setItem_name("機");
		// 		List<ItemBean> bean = itemService.selectByName(selectByNameBean);
		List<ItemBean> list = itemService.selectByNew();
		MemberBean bean = new MemberBean();
		bean.setMember_no(9);
		// 		pageContext.setAttribute("items",list);

		List<Object[]> results = itemService.selectGiveReview(bean);
		int resultsCount = 0;
		List<String> resultList = new ArrayList<String>();
		JSONArray ja = new JSONArray();
		if (results != null) {
			for (Object[] result : results) {
				MemberBean getter = (MemberBean) result[0];
				int member_no = getter.getMember_no();
				String member_photo = getter.getPhoto();
				Integer giverRate = (Integer) result[1];
				String giverReview = (String) result[2];
				JSONObject jo = new JSONObject();
				jo.put("getterID", member_no);
				jo.put("getterPhoto", member_photo);
				jo.put("giverRate", giverRate);
				jo.put("giverReview", giverReview);
				ja.put(jo);
				resultsCount++;
			}
			JSONObject giverReviews = new JSONObject();
			giverReviews.put("giverReviews", ja);
			giverReviews.put("Count", resultsCount);
			pageContext.setAttribute("giverReviews", giverReviews);
		}else{
			JSONObject giverReviews = new JSONObject();
			giverReviews.put("giverReviews","");
			giverReviews.put("Count",0);
		}

		results = itemService.selectGetReview(bean);
		resultsCount = 0;
		JSONArray getja = new JSONArray();
		if (results != null) {
			for (Object[] result : results) {
				MemberBean giver = (MemberBean) result[0];
				int member_no = giver.getMember_no();
				String member_photo = giver.getPhoto();
				Integer getterRate = (Integer) result[1];
				String getterReview = (String) result[2];
				JSONObject jo = new JSONObject();
				jo.put("giverID", member_no);
				jo.put("givererPhoto", member_photo);
				jo.put("getterRate", getterRate);
				jo.put("getterReview", getterReview);
				getja.put(jo);
				resultsCount++;
			}
			JSONObject getReviews = new JSONObject();
			getReviews.put("getReviews", getja);
			getReviews.put("Count", resultsCount);
			pageContext.setAttribute("getterReviews", getReviews);
		}else{
			JSONObject getReviews = new JSONObject();
			getReviews.put("getReviews","");
			getReviews.put("Count",0);
			pageContext.setAttribute("getterReviews", getReviews);
		}
	%>
	<script>
var asgiverReviews = '<%=pageContext.getAttribute("giverReviews")%>';
var asgetterReviews = '<%= pageContext.getAttribute("getterReviews")%>';
giverReviews = JSON.parse(giverReviews);
getterReviews = JSON.parse(getterReviews);
console.log(giverReviews.giverReviews);
console.log(getterReviews.getReviews);
</script>
	<%-- 	<c:forEach var="item" items="${items}"> --%>
	<%-- 	item_no:${item.item_id}<br> --%>
	<%-- 	</c:forEach> --%>
</body>
</html>