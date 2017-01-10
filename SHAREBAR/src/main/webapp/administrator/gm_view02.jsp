<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<style>
</style>
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script> -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>後台系統_物品管理</title>
<link rel="shortcut icon" href="<c:url value='/favicon.ico'/>" type="image/x-icon" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css"> -->
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
<div class="wrap">
<c:import url="../header.jsp"></c:import>

	<div class="row">
		<div class="col-md-1"></div>
	    <div class="col-md-10">
			<nav class="navbar">
				<div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
	
						<a class="navbar-brand" href="#">後台管理系統</a>
					</div>			
				</div>
				<!-- /.container-fluid -->
			</nav>
		</div>
		<div class="col-md-1"></div>
	</div>
	
	<div class="row" >
	<div class="col-md-1"></div>
	
	<div class="col-md-2">
		<div class="list-group">
		  <a href="gm_view01.jsp" class="list-group-item">會員管理</a>
		  <a href="gm_view02.jsp" class="list-group-item active">物品管理</a>
		  <a href="gm_view03.jsp" class="list-group-item">遭檢舉品項</a>
		  <a href="gm_view04_1.jsp" class="list-group-item">客服信箱</a>
		  <a href="../category/CRUDClass.jsp" class="list-group-item">分類管理</a>			 
		</div>
	</div>
	
	<div class="col-md-8">
<!-- 		    <div class="jumbotron"> -->
			
				
				
<!-- 每頁不同的內容從這裡開始 -->
	
	
	<div class="row">
		<div class="col-sm-6">
			<form action="<c:url value="/administrator/SelectBlockItemServlet"/>" method="get">
				<table>
					<tr>
						<td></td>
						<td align="right"><input type="submit" value="選取所有封鎖物品" class="btn btn-default">${errors.system2}</td>
					</tr>			
				</table>		
			</form>
			
			<div>&nbsp;</div>
		
			
			<form action="<c:url value="/administrator/SelectByItemNameServlet"/>" method="get">
				<table>
					<tr>
<!-- 						<td>物品編號:</td> -->
						<td><input type="text" name="item_id" value="${param.item_id}" class="form-control" placeholder="物品編號"></td>				
						<td align="right"><input type="submit" value="搜尋物品" class="btn btn-default">${errors.item_id} ${errors.system}</td>
						<td></td>
					</tr>			
				</table>		
			</form>
		</div>
		
		
	
		<div class="col-sm-6">
			<form action="<c:url value="/administrator/UpdateItemBlockServlet"/>" method="get">
				<table>
					<tr>
						<td></td>
<!-- 						<td>物品編號:</td> -->
						<td><input type="text" name="item_id" value="${param.item_id}" class="form-control" placeholder="物品編號"></td>	
		
						<td align="right"><input type="submit" value="封鎖物品" class="btn btn-danger">${errors.system3}</td>
					</tr>			
				</table>		
			</form>
			
			<div>&nbsp;</div>
			
			<form action="<c:url value="/administrator/ClearItemBlockServlet"/>" method="get">
				<table>
					<tr>
						<td></td>
<!-- 						<td>物品編號:</td> -->
						<td><input type="text" name="item_id" value="${param.item_id}" class="form-control" placeholder="物品編號"></td>	
		
						<td align="right"><input type="submit" value="解封物品" class="btn btn-success">${errors.system4}</td>
					</tr>			
				</table>		
			</form>
			
			
			<div>&nbsp;</div>
		</div>
	</div>
<!-- ----------------------------------------------------------------------------------------------------- -->
	<div>&nbsp;</div>
<!-- 	<h3>搜尋物品結果</h3> -->
	<table class="table table-striped">	
				<tr align="center">
					<td class="st1">物品編號</td>
					<td class="st1">物品名稱</td>
					<td class="st1">描述介紹</td>
					<td class="st1">經度</td>
					<td class="st1">緯度</td>
					<td class="st1">封鎖狀態1</td>
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
	
	
			<c:if test="${not empty item2}">
				<tr>	
					<td class="st1" align="center"><a href="${path}">${item2.item_id}</a></td>
					<td class="st1" align="center">${item2.item_name}</td>
					<td class="st1" >${item2.item_description}</td>
					<td class="st1" align="center">${item2.longitude}</td>
					<td class="st1" align="center">${item2.latitude}</td>
					<td class="st1" align="center">${item2.block}</td>		
				</tr>
			</c:if>
	
	</table>
	

		
		
	
	
	

<!-- 每頁不同的內容到這裡結束 -->
<!-- 			</div> -->
	</div>
	<div class="col-md-1"></div>
	</div>
</div>
<c:import url="/footer.jsp"></c:import>
</body>
</html>