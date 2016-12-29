<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<style>

.st1{
border:1px solid black;
border-collapse:collapse;

}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
	
   <div class="container">
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
	
	
	<div class="col-md-3">
		<div class="list-group">
		  <a href="gm_view01.jsp" class="list-group-item">會員管理</a>
		  <a href="gm_view02.jsp" class="list-group-item">物品管理</a>
		  <a href="gm_view03.jsp" class="list-group-item">遭檢舉品項</a>
		  <a href="gm_view04_1.jsp" class="list-group-item">客服信箱</a>		 
		</div>
	</div>
	
	<div class="col-md-9">
		    <div class="jumbotron">
				<div class="page-header">
					<h3>物品管理介面</h3>
				</div>
				
				
<!-- 每頁不同的內容從這裡開始 -->

	<form action="<c:url value="/administrator/SelectByItemNameServlet"/>" method="get">
		<table>
			<tr>
				<td>(2)搜尋指定編號物品:</td>
				<td><input type="text" name="item_id" value="${param.item_id}"></td>				
				<td align="right"><input type="submit" value="搜尋物品">${errors.item_id} ${errors.system}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>
	
	<form action="<c:url value="/administrator/SelectBlockItemServlet"/>" method="get">
		<table>
			<tr>
				<td>(4)選取所有已封鎖物品:</td>
				<td align="right"><input type="submit" value="執行">${errors.system2}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>
	
	<form action="<c:url value="/administrator/UpdateItemBlockServlet"/>" method="get">
		<table>
			<tr>
				<td>(8)封鎖物品:</td>
				<td>物品編號:</td>
				<td><input type="text" name="item_id" value="${param.item_id}"></td>	

				<td align="right"><input type="submit" value="執行">${errors.system3}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>
	
	<form action="<c:url value="/administrator/ClearItemBlockServlet"/>" method="get">
		<table>
			<tr>
				<td>(9)解封物品:</td>
				<td>物品編號:</td>
				<td><input type="text" name="item_id" value="${param.item_id}"></td>	

				<td align="right"><input type="submit" value="執行">${errors.system4}</td>
			</tr>			
		</table>		
	</form>
	
	
	<div>&nbsp</div>
	
	<h3>搜尋物品結果</h3>
	<table>	
				<tr align="center">
					<td class="st1">&nbsp&nbsp物品編號&nbsp&nbsp</td>
					<td class="st1">&nbsp&nbsp物品名稱&nbsp&nbsp</td>
					<td class="st1">&nbsp&nbsp描述介紹&nbsp&nbsp</td>
					<td class="st1">&nbsp&nbsp經度&nbsp&nbsp</td>
					<td class="st1">&nbsp&nbsp緯度&nbsp&nbsp</td>
					<td class="st1">&nbsp未封鎖0/封鎖1&nbsp</td>
				</tr>
				
				
			<c:forEach var="element2" items="${item}">
				<c:url value="gm_view02.jsp" var="path">
					<c:param name="item_id" value="${element2.item_id}" />
					<c:param name="item_name" value="${element2.item_name}" />
					<c:param name="item_description" value="${element2.item_description}" />
					<c:param name="longitude" value="${element2.longitude}" />
					<c:param name="latitude" value="${element2.latitude}" />
					<c:param name="block" value="${element2.block}" />					
				</c:url>
				
				<tr>
					<td class="st1" align="center"><a href="${path}">${element2.item_id}</a></td>
					<td class="st1" align="center">${element2.item_name}</td>
					<td class="st1" >${element2.item_description}</td>
					<td class="st1" align="center">${element2.longitude}</td>
					<td class="st1" align="center">${element2.latitude}</td>
					<td class="st1" align="center">${element2.block}</td>				
				</tr>
			</c:forEach>		
	
	
			
				<tr>	
					<td class="st1" align="center"><a href="${path}">${item2.item_id}</a></td>
					<td class="st1" align="center">${item2.item_name}</td>
					<td class="st1" >${item2.item_description}</td>
					<td class="st1" align="center">${item2.longitude}</td>
					<td class="st1" align="center">${item2.latitude}</td>
					<td class="st1" align="center">${item2.block}</td>		
				</tr>
			
	
	</table>
	

		
		
	
	
	

<!-- 每頁不同的內容到這裡結束 -->
			</div>
	</div>
	
</body>
</html>