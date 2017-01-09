<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert and update</title>
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="../js/jquery.uploadPreview.min.js"></script>
<style>
.wrapper {
	margin: 0 auto;
/*     overflow: scroll; */
}

.container {
	float: left;
}

.left {
	width: 350px;
}

.right {
	width: 500px;
}

.image-preview {
	width: 150px;
	height: 150px;
	position: relative;
	overflow: hidden;
	background-color: #ffffff;
	color: #ecf0f1;
	float: left;
/* 	margin: 10px; */
	border: silver 1px solid;
}

.image-preview input {
	line-height: 200px;
	font-size: 200px;
	position: absolute;
	opacity: 0;
	z-index: 10;
}

.image-preview label {
	position: absolute;
	z-index: 5;
	opacity: 0.8;
	cursor: pointer;
	background-color: #bdc3c7;
	width: 200px;
	height: 50px;
	font-size: 20px;
	line-height: 50px;
	text-transform: uppercase;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	margin: auto;
	text-align: center;
}
</style>
</head>
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
<c:import url="../header.jsp"></c:import>
<!--    <div id="header"></div> -->
   <div class="row">
   		<div class="col-md-2">
		</div>
	    <div class="col-md-8">
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<a class="navbar-brand" href="#">後台管理系統</a>
					</div>			
				</div>
				<!-- /.container-fluid -->
			</nav>
		</div>
		<div class="col-md-2">
		</div>
	</div>
	
	
	<div class="row">
	
		<div class="col-md-2">
		</div>
		<div class="col-md-2">
			<div class="list-group">
			  <a href="../administrator/gm_view01.jsp" class="list-group-item">會員管理</a>
			  <a href="../administrator/gm_view02.jsp" class="list-group-item">物品管理</a>
			  <a href="../administrator/gm_view03.jsp" class="list-group-item">遭檢舉品項</a>
			  <a href="../administrator/gm_view04_1.jsp" class="list-group-item">客服信箱</a>
			  <a href="../category/CRUDClass.jsp" class="list-group-item active">分類管理</a>	
			</div>
		</div>
		
		<div class="col-md-6">
<!-- 			    <div class="jumbotron"> -->
		
		
		
		<c:url value="/" var="root"></c:url>
		<div class="wrapper">
			<div class="container left">
				<form action="<c:url value="/category/crud.controller" />" method="post" enctype="multipart/form-data">
					<div>
						<div class="form-group">
							<label for="id_class_id">分類編號</label>
							<input type="text" id="id_class_id" class="form-control" name="class_id" value="${param.class_id}">
						</div>
						<div class="form-group">
							<label for="id_class_name">分類名稱</label>
							<input type="text" id="id_class_name" class="form-control" name="class_name" value="${param.class_name}">
						</div>
						<div>
							<div style="width:150px;height:150px;float:left">
								<img src="${root}category-image/${param.image}" style="width:100%">
							</div>
							<div id="id_image_div" class="form-group image-preview">
								<label for="id_image_input" id="id_image_label">分類照片</label>
								<input type="file" id="id_image_input" name="image">
							</div>
						</div>
							<div style="width:150px;height:150px;float:left">
								<img src="${root}category-icon/${param.icon}">
							</div>
							<div id="id_icon_div" class="form-group image-preview">
								<label for="id_icon_input" id="id_icon_label">地圖標記</label>
								<input type="file" id="id_icon_input" name="icon">
							</div>
						<div>
							<div style="width:150px;height:150px;float:left">
								<img src="${root}category-icon/${param.icon_after}">
							</div>
							<div id="id_icon_after_div" class="form-group image-preview">
								<label for="id_icon_after_input" id="id_icon_after_label">地圖標記（後）</label>
								<input type="file" id="id_icon_after_input" name="icon_after">
							</div>				
						</div>
						<div class="form-group">
							<input type="submit" value="新增" class="btn btn-default" name="class_action">
							<input type="submit" value="修改" class="btn btn-default" name="class_action">
							<input type="submit" value="刪除" class="btn btn-default" name="class_action">
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
		
<!-- 				</div> -->
	</div>
	
	</div>
	<script>
// 		$(function(){
// 			$("#header").load("../header.jsp");
// 		});
	
		$(function() {
			
			// 照片預覽
			$.uploadPreview({
				input_field: "#id_image_input",		// Default: .image-upload
				preview_box: "#id_image_div",		// Default: .image-preview
				label_field: "#id_image_label",		// Default: .image-label
				label_default: "選擇照片",			// Default: Choose File
				label_selected: "更換照片",			// Default: Change File
				no_label: false						// Default: false
			});
			$.uploadPreview({
				input_field: "#id_icon_input",		// Default: .image-upload
				preview_box: "#id_icon_div",		// Default: .image-preview
				label_field: "#id_icon_label",		// Default: .image-label
				label_default: "選擇照片",			// Default: Choose File
				label_selected: "更換照片",			// Default: Change File
				no_label: false						// Default: false
			});
			$.uploadPreview({
				input_field: "#id_icon_after_input",	// Default: .image-upload
				preview_box: "#id_icon_after_div",		// Default: .image-preview
				label_field: "#id_icon_after_label",	// Default: .image-label
				label_default: "選擇照片",				// Default: Choose File
				label_selected: "更換照片",				// Default: Change File
				no_label: false							// Default: false
			});
		});
	</script>
</body>
</html>