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
<title>信箱功能_會員查詢信件</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
<c:import url="../header.jsp"></c:import>
<!-- <div id="header"></div> -->
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
		  <a href="gm_view05_1.jsp" class="list-group-item">我的信箱</a>
		</div>
	</div>
	
	<div class="col-md-9">
		    <div class="jumbotron">
				<div class="page-header">
					<h3>信箱介面</h3>
				</div>
				
	<ul class="nav nav-tabs">
        <li class="active"><a href="gm_view05_1.jsp">查詢信件</a></li>
        <li>               <a href="gm_view05_2.jsp">寫客服信</a></li>
    </ul>			
<!-- 每頁不同的內容從這裡開始 -->
	<div> &nbsp</div>

	<form action="<c:url value="/administrator/MailSelectForCustomerServlet"/>" method="get">
		<table>
			<tr>
				<td>(1)會員查信:</td>
			</tr>
			<tr>
				<td>會員編號已從帳號擷取:</td>
				<td><input type="hidden" name="member_id" value="${user.member_no}"></td>			
				<td align="left"><input type="submit" value="更新信件">${errors.system}</td>
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
				<c:url value="gm_view05_1.jsp" var="path">
					<c:param name="mail_id" value="${element4.mail_id}" />
					<c:param name="member_id" value="${element4.member_id}" />
					<c:param name="time" value="${element4.time}" />
					<c:param name="context" value="${element4.context}" />
					<c:param name="reply_time" value="${element4.reply_time}" />
					<c:param name="gm_reply_context" value="${element4.gm_reply_context}" />				
				</c:url>

				<tr>
					<td align="center"  class="st1">${element4.mail_id}</td>
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
<div id="footer"></div>
</body>
</html>