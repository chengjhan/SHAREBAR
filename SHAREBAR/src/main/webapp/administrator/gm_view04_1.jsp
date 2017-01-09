<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<style>

/* .st1{ */
/* border:1px solid black; */
/* border-collapse:collapse; */

/* } */
</style>
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script> -->
<script type="text/javascript">
// $(function(){
// 	$("#header").load("../header.jsp");
	
// 	$("#footer").load("../footer.jsp");
// });
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>後台系統_查詢會員信件</title>
<link rel="shortcut icon" href="<c:url value='/favicon.ico'/>" type="image/x-icon" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
<c:import url="../header.jsp"></c:import>
<!-- <div id="header"></div>	 -->
	<div class="row">
		<div class="col-md-2"></div>
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
		<div class="col-md-2"></div>
	</div>
	
	<div class="row" >
	<div class="col-md-2"></div>
	
	<div class="col-md-2">
		<div class="list-group">
		  <a href="gm_view01.jsp" class="list-group-item">會員管理</a>
		  <a href="gm_view02.jsp" class="list-group-item">物品管理</a>
		  <a href="gm_view03.jsp" class="list-group-item">遭檢舉品項</a>
		  <a href="gm_view04_1.jsp" class="list-group-item active">客服信箱</a>
		  <a href="../category/CRUDClass.jsp" class="list-group-item">分類管理</a>			 		 		 
		</div>
	</div>
	
	
	
	<div class="col-md-7">
<!-- 		    <div class="jumbotron"> -->
				
				
				
		
	<ul class="nav nav-tabs">
        <li class="active"><a href="gm_view04_1.jsp">查詢信件</a></li>
        <li>               <a href="gm_view04_2.jsp">回覆信件</a></li>
    </ul>		
    
<!-- 每頁不同的內容從這裡開始 -->
	<div>&nbsp;</div>
	
	<form action="<c:url value="/administrator/MailSelectAllServlet"/>" method="get">
		<table>
			<tr>
				<td></td>						
				<td align="right"><input type="submit" value="更新會員郵件" class="btn btn-success">${errors.system2}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp;</div>
	
	<form action="<c:url value="/administrator/MailSelectMemberNoServlet"/>" method="get">
		<table>
			<tr>
<!-- 				<td>會員編號:</td> -->
				<td><input type="text" name="member_id" value="${param.member_id}" class="form-control" placeholder="會員編號"></td>			
				<td align="right"><input type="submit" value="搜尋指定郵件" class="btn btn-default">${errors.system}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp;</div>
	
	
	
<!-- 	<h3>搜尋信件結果</h3> -->
	<table class="table table-striped">	
				<tr align="center">
					<td class="st1">信件編號</td>
					<td class="st1">會員ID</td>
					<td class="st1">投訴時間</td>			
					<td class="st1">信件內容</td>
					<td class="st1">回覆時間</td>
					<td class="st1">客服回覆</td>
					
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
					<td class="st1">&nbsp; ${element4.time} &nbsp;</td>	
					<td class="st1">${element4.context}</td>
					<td class="st1">&nbsp; ${element4.reply_time} &nbsp;</td>	
					<td class="st1">${element4.gm_reply_context}</td>		
				</tr>
			</c:forEach>		
	</table>
	

<!-- 每頁不同的內容到這裡結束 -->
<!-- 			</div> -->
	</div>
	</div>
<div style="height:330px"></div>
<c:import url="/footer.jsp"></c:import>
</body>
</html>