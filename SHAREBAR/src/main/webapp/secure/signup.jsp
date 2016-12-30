<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <script src="../js/jquery-3.1.1.min.js"></script> -->
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<script src="../js/bootstrap-validator.js"></script>
<title>SignUp</title>
<style type="text/css">
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

/* #sign_up_div { */
/* 	margin: 5px; */
/* 	padding: 5px; */
/* 	width:auto; */
/* 	height:auto; */
/* } */

/* #sign_up { */
/* 	border: 1px solid black; */
/* 	width:600px; */
/* 	height:auto; */
/* } */

.error {
	color: #F00;
	font-weight: bold;
}
#message{
	color: #F00;
	font-weight: bold;
}
form#sign_up{ 
	margin: 100px auto; 
	width:250px;
}
a#fbsign{
	margin: 100px auto; 
	width:250px;
}
img#imgPreview{
	width: 100px;
	height: 100px;
}
</style>

<script>
$(function(){
	$("#header").load("../header.jsp");
	
	$("#footer").load("../footer.jsp");
});
</script>
</head>
<body>
<%@page import="java.net.URLEncoder" %>
<%
    String fbURL = "http://www.facebook.com/dialog/oauth?client_id=903433963124082&redirect_uri=" + URLEncoder.encode("http://localhost:8080/Project/signin_fb.controller?")+"&scope=email";
%>
<div id="header"></div>
<%-- <a id="fbsign" href="<%= fbURL %>"><img src="../img/facebookloginbutton.png" border="0" class="form-control"/></a> --%>
	<div id="sign_up_div" class="row">
		<form id="sign_up" data-toggle="validator" action="signup.controller" method="POST" enctype="multipart/form-data">
			<legend>Personal info: </legend>
			<div class="form-group">
			<label for="first_name">First name:</label><input type="text" class="form-control" id="first_name" name="first_name" value="${param.first_name}" autofocus required>
			</div>
			<div class="form-group">
			<label for="last_name">Last name:</label><input type="text" class="form-control" id="last_name" name="last_name" value="${param.last_name}" required>
			</div>
			<div class="form-group">
			<label for="country">Country:</label><input type="text" class="form-control" id="country" name="country" value="${param.country}" required>
			</div>
			<div class="form-group">
			<label for="city">City:</label><input type="text" class="form-control" id="city" name="city" value="${param.city}" required>
			</div>
			<legend>Sign Up:</legend>
			<div class="form-group">
			<label for="member_email">Account name(email):</label><input type="email" class="form-control" id="member_email" name="member_email" placeholder="Email" value="${param.memberemail}" data-error="Bruh, that email address is invalid" required/>${errors.id}
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="password">Password:</label><input type="password" class="form-control" id="password" name="password" data-minlength="8" placeholder="Password" data-error="Minimum of 8 characters"required>${errors.password}
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="confirm_password">confirm_password:</label> <input type="password" class="form-control" id="confirm_password" name="confirm_password" data-match="#password" data-error="woops, doen't match password" required>
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="member_nickname">Presented name:</label></label><input type="text" class="form-control" id="member_nickname" name="member_nickname" value="${param.member_nickname}" data-error="This is what other user would see" required>${errors.nickname}
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="member_description">Description:</label><textarea type="text" class="form-control" id="member_description" name="member_description" value="${param.member_description}" maxlength="50" data-error="Please introduce yourself" required></textarea>${errors.description}
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="member_photo">Image:</label><input type="file" class="form-control-file" id="member_photo" name="member_photo" accept="image/x-png" data-error="Please input a png file" required>${errors.photo}<br><br><br>
			<img id="imgPreview"alt="your image" src="profilePerson.png" >
			</div>
			<div class="form-group">
			<button type="submit" class="btn btn-primary">Send</button> <button type="reset" class="btn btn-primary">Reset</button>
			</div>
			<div id="message">${errors.system}</div>
		</form>
	</div>
	<div id="footer"></div>
	<script>
	$(function(){
	    function readURL(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            
	            reader.onload = function (e) {
	                $('#imgPreview').attr('src', e.target.result);
	            }            
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
	    $("#member_photo").change(function(){
	        readURL(this);
	    });
	});//end of ready
	</script>
</body>
</html>