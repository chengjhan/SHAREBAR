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
<script type="text/javascript">
// $(function(){
// 	$("#header").load("../header.jsp");
	
// 	$("#footer").load("../footer.jsp");
// });
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>後台系統_回覆會員信件</title>
<link rel="shortcut icon" href="<c:url value='/favicon.ico'/>" type="image/x-icon" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
<div class="wrap">
<c:import url="../header.jsp"></c:import>
<!-- <div id="header"></div> -->
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
	
	
	
	<div class="col-md-6">
<!-- 		    <div class="jumbotron"> -->
				
				
				
		
	<ul class="nav nav-tabs">
        <li>               <a href="gm_view04_1.jsp">查詢信件</a></li>
        <li class="active"><a href="gm_view04_2.jsp">回覆信件</a></li>
    </ul>		
    
<!-- 每頁不同的內容從這裡開始 -->
	
	<div>&nbsp;</div>

	
<%-- 			<form action="<c:url value="/administrator/MailReplyServlet"/>" method="get"> --%>
<!-- 				<table> -->
<!-- 					<tr> -->
<!-- 						<td><h3>管理員回覆</h3></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>信件編號:</td> -->
<%-- 						<td><input type="text" name="mail_id" value="${param.mail_id}"></td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>信件內容</td> -->
<%-- 						<td><input class="st2" placeholder="輸入回覆內容" type="text" name="gm_reply_context" value="${param.gm_reply_context}"></td> --%>
										
<%-- 						<td align="right"><input type="submit" value="發送信件">${errors.system}</td> --%>
<!-- 					</tr>			 -->
<!-- 				</table>		 -->
<!-- 			</form> -->
	
			<div >
				<td><label>信件編號:</label></td>
				<td><input type="text" name="mail_id" value="${param.mail_id}" id="mail" placeholder="請輸入信件編號" ></td>
				<div><textarea style="width:500px;height:200px;" id="reply">請輸入回覆內容...</textarea></div>							
				<div><input  type="button" id="send" value="發送郵件" class="btn btn-default"></div>	
			</div>

<script>
			
			$('div #send').click(function(){
					alert("信件已寄出");				
				var mail_id = $("#mail").val();
				var gm_reply_context = $("#reply").val();
// 					alert("mail_id = " + mail_id);
// 					alert("gm_reply_context = " + gm_reply_context);
				$.get("MailReplyServlet" , {"mail_id":mail_id, "gm_reply_context":gm_reply_context} );			
			})

</script>



<!-- 每頁不同的內容到這裡結束 -->
<!-- 			</div> -->
	</div>
	</div>
</div>
<c:import url="/footer.jsp"></c:import>
</body>
</html>