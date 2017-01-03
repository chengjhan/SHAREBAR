<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="display.controller" method="get">
			<div>
				<label for="id_member">會員</label>
				<input type="text" id="id_member" name="member_id" value="aaa@aaa.com">
			</div>
			<div>
				<input type="submit" value="搜尋">
			</div>
		</form>
	</div>
	<div>
		<table border="1">
			<thead>
				<tr>
					<td>item_id</td>
					<td>item_name</td>
					<td>location</td>
					<td>class_name</td>
					<td>end_date</td>
					<td>item_description</td>
					<td>image_photo1</td>
					<td>image_photo2</td>
					<td>image_photo3</td>
					<td>image_photo4</td>
				</tr>	
			</thead>
			<tbody>
				<c:forEach var="bean" items="${itemBean}">
					<c:url value="/item/UpdateItem.jsp" var="path">
						<c:param name="item_id" value="${bean.item_id}" />
						<c:param name="item_name" value="${bean.item_name}" />
						<c:param name="location" value="${bean.location}" />
						<c:param name="class_name" value="${bean.classBean.class_name}" />						
						<c:param name="end_date" value="${bean.end_date}" />
						<c:param name="item_description" value="${bean.item_description}" />
						<c:forEach var="imageBean" items="${bean.imageBean}" varStatus="varStatus">
							<c:param name="image_id${varStatus.count}" value="${imageBean.image_id}" />
						</c:forEach>
					</c:url>
					<tr>
						<td><a href="${path}">${bean.item_id}</a></td>
						<td>${bean.item_name}</td>
						<td>${bean.location}</td>
						<td>${bean.classBean.class_name}</td>
						<td>${bean.end_date}</td>
						<td>${bean.item_description}</td>
<%-- 						<c:forEach var="imageBean" items="${bean.imageBean}" varStatus="varStatus"> --%>
<%-- 							<td>${imageBean.image_id}</td> --%>
<%-- 						</c:forEach> --%>
<%-- 						<td>${imageBean.image_id1}</td> --%>
<%-- 						<td>${imageBean.image_id2}</td> --%>
<%-- 						<td>${imageBean.image_id3}</td> --%>
<%-- 						<td>${imageBean.image_id4}</td> --%>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>