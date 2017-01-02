<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert and update</title>
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="../js/jquery-3.1.1.min.js"></script>
</head>
<style>
.wrapper {
	width: 800px;
	margin: 0 auto;
	overflow: scroll;
}

.container {
	float: left;
}

.left {
	width: 300px;
}

.right {
	width: 500px;
}
</style>
<body>
	<%@ page import="org.springframework.web.context.WebApplicationContext"%>
	<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
	<%@ page import="category.model.*"%>
	<%@ page import="category.model.dao.*"%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="java.util.Base64"%>
	<%
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

		ClassService classService = (ClassService) context.getBean("classService");
		List<ClassBean> list = classService.select(null);
		request.setAttribute("classBean", list);
		
// 		for (ClassBean bean : list) {
// 			byte[] encodeBase64 = Base64.getEncoder().encode(bean.getImage());
// 			String base64Encoded = new String(encodeBase64, "UTF-8");
// 			request.setAttribute("image", base64Encoded);
// 		}
	%>
	<c:url value="/" var="root"></c:url>
	<div class="wrapper">
		<div class="container left">
			<form action="<c:url value="/category/crud.controller" />" method="post" enctype="multipart/form-data">
				<div>
					<div class="form-group">
						<label for="id_class_name">分類名稱</label>
						<input type="text" id="id_class_name" class="form-control" name="class_name" value="${param.class_name}">
					</div>
					<div class="form-group">
						<label for="id_image">分類照片</label>
						<input type="file" id="id_image" class="form-control" name="image">
					</div>
					<div class="form-group">
						<label for="id_image">地圖標記</label>
						<input type="file" id="id_icon" class="form-control" name="icon">
					</div>
					<div class="form-group">
						<label for="id_image">地圖標記（後）</label>
						<input type="file" id="id_icon_after" class="form-control" name="icon_after">
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-default" value="新增">
					</div>
				</div>
			</form>
		</div>
		<div class="container right">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<td>class_id</td>
							<td>class_name</td>
							<td>image</td>
							<td>icon</td>
							<td>icon_after</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bean" items="${classBean}" varStatus="varStatus">
							<c:url value="/category/CRUDClass.jsp" var="path">
								<c:param name="class_id" value="${bean.class_id}" />
								<c:param name="class_name" value="${bean.class_name}" />
								<c:param name="image" value="${bean.image}" />
								<c:param name="icon" value="${bean.icon}" />						
								<c:param name="icon_after" value="${bean.icon_after}" />
							</c:url>
							<tr>
								<td><a href="${path}">${bean.class_id}</a></td>
								<td>${bean.class_name}</td>
<%-- 								<td><img src="data:image/jpeg;base64,${image}" style="width:50%;height:auto"></td> --%>
								<td><img src="${root}category-image/${bean.image}" style="width:50%;height:auto"></td>
								<td><img src="${root}category-icon/${bean.icon}"></td>
								<td><img src="${root}category-icon/${bean.icon_after}"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>