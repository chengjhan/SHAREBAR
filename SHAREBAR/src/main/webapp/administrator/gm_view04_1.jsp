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
					<h3>信箱介面</h3>
				</div>
		
	<ul class="nav nav-tabs">
        <li class="active"><a href="gm_view04_1.jsp">查詢信件</a></li>
        <li>               <a href="gm_view04_2.jsp">回覆信件</a></li>
    </ul>		
    
<!-- 每頁不同的內容從這裡開始 -->
	<div>&nbsp</div>
	
	<form action="<c:url value="/administrator/MailSelectMemberNoServlet"/>" method="get">
		<table>
			<tr>
				<td>(1)會員編號:</td>
				<td><input type="text" name="member_id" value="${param.member_id}"></td>			
				<td align="right"><input type="submit" value="搜尋郵件">${errors.system}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>
	
	<form action="<c:url value="/administrator/MailSelectAllServlet"/>" method="get">
		<table>
			<tr>
				<td>(2)管理員察看客服信件:</td>						
				<td align="right"><input type="submit" value="搜尋所有郵件">${errors.system2}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>
	
	<h3>搜尋信件結果</h3>
	<table>	
				<tr align="center">
					<td class="st1">&nbsp信件編號&nbsp</td>
					<td class="st1">&nbsp會員ID&nbsp</td>
					<td class="st1">&nbsp投訴時間&nbsp</td>			
					<td class="st1">&nbsp信件內容&nbsp</td>
					<td class="st1">&nbsp回覆時間&nbsp</td>
					<td class="st1">&nbsp客服回覆&nbsp</td>
					
				</tr>
			<c:forEach var="element4" items="${mail}">
				<c:url value="gm_view04_2.jsp" var="path">
					<c:param name="mail_id" value="${element4.mail_id}" />
					<c:param name="member_id" value="${element4.member_id}" />
					<c:param name="time" value="${element4.time}" />
					<c:param name="context" value="${element4.context}" />
					<c:param name="reply_time" value="${element4.reply_time}" />
					<c:param name="gm_reply_context" value="${element4.gm_reply_context}" />				
				</c:url>

				<tr>
					<td align="center"  class="st1"><a href="${path}">${element4.mail_id}</a></td>
					<td align="center"  class="st1">${element4.member_id}</td>		
					<td class="st1">&nbsp ${element4.time} &nbsp</td>	
					<td class="st1">${element4.context}</td>
					<td class="st1">&nbsp ${element4.reply_time} &nbsp</td>	
					<td class="st1">${element4.gm_reply_context}</td>		
				</tr>
			</c:forEach>		
	</table>
	

<!-- 每頁不同的內容到這裡結束 -->
			</div>
	</div>
	
</body>
</html>