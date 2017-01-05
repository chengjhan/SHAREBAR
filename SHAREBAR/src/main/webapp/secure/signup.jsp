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
<meta name="google-signin-client_id"
	content="307771007729-rmscbeafik1eh81eo2v9rtv4bb5n1tml.apps.googleusercontent.com">
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<script src="../js/bootstrap-validator.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script><!-- GSignIn -->
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
div#sign_up_div{
	margin:auto auto;
	width:300px;
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
#g-signin2{
	width:100%;
}
</style>
</head>
<%
String from = request.getHeader("Referer"); 
session.setAttribute("from",from);
%>
<body>
<div id="header"></div>
	<div id="sign_up_div" class="row">
		<form id="sign_up" data-toggle="validator" action="signup.controller" method="POST" enctype="multipart/form-data">
			<div class="form-group">
			<div id="g-signin2" class="g-signin2" data-onsuccess="onSignIn" data-width="240" data-height="50" data-longtitle="true">
			</div>
			<div id="Gerror" class="form-group">
			</div>
			<legend>Personal info: </legend>
			<div class="form-group">
			<label for="first_name">First name:</label><input type="text" class="form-control" id="first_name" name="first_name" value="${param.first_name}" required>
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
		$("#header").load("../header.jsp");
		
		//切換圖片用================================
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
	    //========================================
	    		    
	});//end of ready
	
    function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		var id_token = googleUser.getAuthResponse().id_token;
		
		console.log('profile: ' + profile);
		console.log('id_token: ' + id_token);
		console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		console.log('Name: ' + profile.getName());
		console.log('Given Name: ' + profile.getGivenName());
		console.log('Family Name: ' + profile.getFamilyName());
		console.log('Image URL: ' + profile.getImageUrl());
		console.log('Email: ' + profile.getEmail());
		console.log('===========================================');

		
		$.post("tokensignin",{"id_token":id_token,"ID":profile.getId(),"Name":profile.getName(),"Given Name":profile.getGivenName(),"Family Name":profile.getFamilyName(),"Image URL":profile.getImageUrl(),"Email":profile.getEmail()},function(responseText){
			if(responseText == "GLoginSuccess"){
				console.log(responseText);
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				window.location = "<%=from%>";
			}else if(responseText == "AccountExist"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				$("#Gerror").empty();
				$("#Gerror").append( "<p style='color:red'>connecting error please try other method.</p>" );
			}else if(responseText == "GSignAndLoginSuccess"){
				console.log(responseText);
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				window.location = "<%=from%>";
			}else if(responseText == "InvalidIdToken"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				console.log(responseText);
				$("#Gerror").empty();
				$("#Gerror").append( "<p style='color:red'>connecting error please try other method.</p>" );
			}else if(responseText == "GLoginfail"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				console.log(responseText);
				$("#Gerror").empty();
				$("#Gerror").append( "<p style='color:red'>the account with this email is already exist</p>" );
			}else if(responseText == "alreadyLogin"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				window.location = "<%=from%>";
			}
		});
	}
	</script>
</body>
</html>