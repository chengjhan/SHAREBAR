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
$(function(){
	$("#header").load("../header.jsp");
	
	$("#footer").load("../footer.jsp");
});
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>後台系統_舉報單列表</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</head>

<body>
<div id="header"></div>	
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
					<h3>舉報清單</h3>
				</div>
				
				
<!-- 每頁不同的內容從這裡開始 -->
	<form action="<c:url value="/administrator/ReportInsertServlet"/>" method="get">
		<table>
			<tr>
				<td>(5-1 , 5-2)檢舉物品</td>
			</tr>
			<tr>
				<td>舉報人:</td>
				<td><input type="text" name="reporting_member_id" value="${param.reporting_member_id}"></td>
			</tr>
				<td>被檢舉物編號:</td>
				<td><input type="text" name="reported_item_id" value="${param.reported_item_id}"></td>
			<tr>
				<td>違規事項描述:</td>
				<td><input type="text" name="context" value="${param.context}"></td>
				<td align="right"><input type="submit" value="執行">${errors.system}</td>
			</tr>			
		</table>		
	</form>
	
	<div>&nbsp</div>
	
	<form action="<c:url value="/administrator/ReportSelectAllServlet"/>" method="get">		
			<tr>		
				<td><input type="submit" value="更新檢舉物品清單"></td>			
			</tr>			
	</form>
	
	<div>&nbsp</div>
	
	
	
	<table>	
				<tr align="center">
					<td class="st1">&nbsp # &nbsp</td>
					<td class="st1">&nbsp檢舉人ID&nbsp</td>
					<td class="st1">&nbsp檢舉人帳號&nbsp</td>
					<td class="st1">&nbsp檢舉人暱稱&nbsp</td>
					<td class="st1">&nbsp被檢舉物ID&nbsp</td>
					<td class="st1">&nbsp被檢舉物名稱&nbsp</td>
					<td class="st1">違規描述</td>
					<td class="st1">檢舉時間</td>
					<td class="st1">&nbsp&nbsp封鎖&nbsp&nbsp</td>
				</tr>
			<c:forEach var="element3" items="${report}">
				<c:url value="gm_view03.jsp" var="path">
					<c:param name="report_id" value="${element3.report_id}" />
					<c:param name="reporting_member_id" value="${element3.reporting_member_id.member_no}" />
					<c:param name="reported_item_id" value="${element3.reported_item_id.item_id}" />
					<c:param name="context" value="${element3.context}" />	
					<c:param name="time" value="${element3.time}" />							
				</c:url>

				<tr>
					<td align="center" class="st1">${element3.report_id}</td>
					<td align="center" class="st1">${element3.reporting_member_id.member_no}</td>
					<td align="center" class="st1">${element3.reporting_member_id.email}</td>
					<td align="center" class="st1">${element3.reporting_member_id.nickname}</td>
					<td align="center" class="st1">${element3.reported_item_id.item_id}</td>
					<td align="center" class="st1">${element3.reported_item_id.item_name}</td>
					<td class="st1">${element3.context}</td>		
					<td class="st1">&nbsp ${element3.time} &nbsp</td>
					<td align="center" class="st1"><a href="${path}">封鎖</a></td>
				</tr>
			</c:forEach>		
	</table>
	

<!-- 每頁不同的內容到這裡結束 -->
			</div>
	</div>
<div id="footer"></div>	
</body>
</html>