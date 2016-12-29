<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap5/js/bootstrap.min.js"></script> -->
<title>Login</title>
<style type="text/css">
.error{
	color: #F00;
	font-weight: bold;
}
form { 
	margin: 100px auto; 
	width:250px;
}
</style>
<script>
$(function(){
	$("#header").load("../header.jsp");
})
</script>
</head>
<body>
<header id="header"></header>
<div id="login_div">
<form id="login_form" method="POST" action="login.controller">
<legend>Login:</legend>
<div class="form-group">
<label for="email">User: </label><input type="text" class="form-control" id="email" name="email"><br><div class="error" autofocus>${errors.email}</div>
</div>
<div class="form-group">
<label for="password">Password: </label><input type="password" class="form-control" id="password" name="password"><br><div class="error">${errors.password}</div>
</div>
<div class="form-group">
<button type="submit" class="btn btn-primary">Send</button>
</div>
<div class="error">${errors.system}</div>
</form>
</div>
</body>
</html>