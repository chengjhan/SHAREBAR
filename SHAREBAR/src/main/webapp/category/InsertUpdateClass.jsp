<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert and update</title>
</head>
<body>
	<div>
		<form action="<c:url value="/category/crud.controller" />" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>分類名:</td>
					<td><input type="text" name="class_name"></td>
					<td>${errors.class_name}</td>
				</tr>
				<tr>
					<td>分類圖:</td>
					<td><input type="file" name="image"></td>
					<td>${errors.image}</td>
				</tr>
				<tr>
					<td>
						<select name="selector">
							<option value="Select">查詢</option>
							<option value="Insert">新增</option>
							<option value="Update">修改</option>
							<option value="delete">刪除</option>
						</select>
					</td>
					<td><input type="submit" value="確定"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>