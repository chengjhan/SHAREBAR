<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="classblock">
					<h3>會員編號：${user.member_no}</h3>
					<h3>會員信箱：${user.member_email}</h3>
					<h3>會員暱稱：${user.member_nickname}</h3>
					<h1>Here is mail_button.</h1>
					<form action='<c:url value="maillist.controller"/>' method="get">
						<table align="center">
							<tr>
								<td style="color: black;">
								<input type="hidden" name="member_id" value="${user.member_no}"> 
								<input type="hidden" name="member_email" value="${user.member_email}">
								<input type="hidden" name="member_nickname" value="${user.member_nickname}">
								<input type="submit" value="maillist" >
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>