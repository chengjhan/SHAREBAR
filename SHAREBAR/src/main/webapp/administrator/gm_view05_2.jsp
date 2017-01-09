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
<title>信箱功能_會員撰寫客服信件</title>
<link rel="shortcut icon" href="<c:url value='/favicon.ico'/>" type="image/x-icon" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
<c:import url="../header.jsp"></c:import>
<!-- <div id="header"></div>		 -->
   <div class="container">
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">

					<a class="navbar-brand" href="#">聯絡客服人員</a>
				</div>			
			</div>
			<!-- /.container-fluid -->
		</nav>
	</div>
	
	
	<div class="col-md-3">
		<div class="list-group">
		  <a href="gm_view05_2.jsp" class="list-group-item">我的信箱</a>
		</div>
	</div>
	
	<div class="col-md-9">
		    <div class="jumbotron">
				<div class="page-header">
					<h3>信箱介面</h3>
				</div>
				
	<ul class="nav nav-tabs">
        <li><a href="gm_view05_1.jsp">查詢信件</a></li>
        <li class="active"><a href="gm_view05_2.jsp">寫客服信</a></li>
    </ul>			
<!-- 每頁不同的內容從這裡開始 -->

	
	<div> &nbsp</div>
	
	<form action="<c:url value="/administrator/MailInsertServlet"/>" method="get">
		<table>
			<tr>
				<td>(3)寫客服信:</td>
			</tr>
			<tr>
				<td>會員編號已從帳號擷取:</td>
				<td><input type="hidden" name="member_id" value="${user.member_no}"></td>
			</tr>
			<tr>
				<td>信件內容:</td>
				<td><input type="text" name="context" value="${param.context}"></td>									
				<td align="left"><input type="submit" value="發送信件">${errors.system}</td>
			</tr>
			<tr>
				
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>

	
	
	

<!-- 每頁不同的內容到這裡結束 -->
			</div>
	</div>
<div id="footer"></div>	
</body>
</html>