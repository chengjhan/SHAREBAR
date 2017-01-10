<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="../js/bootstrap-validator.js"></script>
<title>SignUp</title>
<style type="text/css">
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.error {
	color: #F00;
	font-weight: bold;
}
#message{
	color: #F00;
	font-weight: bold;
}
form{ 
	margin: 100px auto; 
	width:auto;
}
img#imgPreview{
	width: 100px;
	height: 100px;
}
div.list-group{
	margin: 100px auto; 
}
.container{
	margin:50px auto
}
.row>[class*='col-']{
 	display: table-cell;
	vertical-align:center;
	flex: 1; /* additionally, equal width */
	padding: 1em;
	horizontal-align:center;
}
</style>

</head>
<body>
<c:url value="/" var="root"></c:url>
<jsp:include page="../header.jsp"></jsp:include>

	<div class="container">
	<div id="sign_up_div" class="row">
	<div class="col-md-3">
		<div class="list-group">
			<a href="changeInfo.jsp" class="list-group-item">CHANGE PROFILE</a>
			<a href="changePassword.jsp" class="list-group-item">CHANGE PASSWORD</a>
		</div>
	</div>
	<div class="col-md-9">
		<form id="sign_up" data-toggle="validator" action=changePassword.do method="POST">
			<legend>Update info: </legend>
			<div class="form-group">
			<label for="old_password">Old Password:</label><input type="password" class="form-control" id="old_password" name="old_password" required>${errors.oldpassword}
			</div>
			<div class="form-group">
			<label for="new_password">New Password:</label><input type="password" class="form-control" id="new_password" name="new_password" data-minlength="8" data-error="Minimum of 8 characters" required>${errors.newpassword}
			</div>
			<div class="form-group">
			<label for="conf_new">Confirm New Password:</label><input type="password" class="form-control" id="conf_new" name="conf_new" data-match="#new_password" data-error="woops, doen't match password" required>
			</div>
			<button type="submit" class="btn btn-primary">Store</button>${errors.system}
		</form>
	</div>
	</div>
	</div>
	<script>
	</script>
</body>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>

</html>