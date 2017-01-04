<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap5/js/bootstrap.min.js"></script> -->
<script type="text/javascript">

$(function(){
	
	$('#member_id').change(function(){
		alert("test")
		
	})
	
		$('#follow').click(function(){
		
		
	
		$.post("followerItem.controller",{"MemberID":1,"ItemID":$("#item_id").val()}),
		function(data){
			$('#msg').html("<h2>" + data + "</h2>");
		
		}
		})
// 	}
	
});
	

	
</script>
<title>Insert title here</title>
</head>
<body>

<div class="container-fluid">

<form action="<c:url value="showitems.controller"/>" method="get">
<table>
	<tr>
		<td>MemberID : </td>
		<td><input type="text" name="userid" value=></td>
		<td></td>
	</tr>
	
	<tr>
		<td>　</td>
		<td align="right"><input type="submit" value="追蹤物品清單"></td>
	</tr>
</table>
</form>

<p/>

<form action="followItem.do" method="post">
<table>
	<tr>
		<td>MemberID : </td>
		<td><input type="text" id="MemberID" name="MemberID" ></td>
		<td></td>
	</tr>
	<tr>
		<td>ItemID : </td>
		<td><input type="text" id="ItemID" name="ItemID" ></td>
		<td></td>
	</tr>
	
	<tr>
		<td>　</td>
		<td align="right"><input type="submit" value="追蹤" id="follow"></td>
	</tr>
	<p id="msg"></p>
</table>
</form>

</div>






</body>
</html>