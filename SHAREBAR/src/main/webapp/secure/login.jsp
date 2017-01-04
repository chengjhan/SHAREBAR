<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-client_id"
	content="307771007729-rmscbeafik1eh81eo2v9rtv4bb5n1tml.apps.googleusercontent.com">
<script src="../js/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script><!-- GSignIn -->
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
div#g-signin2{
	display:inline;
}
</style>
</head>
<%
String from = request.getHeader("Referer"); 
session.setAttribute("from",from);
%>
<body>
<div id="header"></div>
<div id="login_div">
<form id="login_form" method="POST" action="login.controller">
<div class="form-group">
<div id="g-signin2" class="g-signin2" data-onsuccess="onSignIn" data-width="240" data-height="50" data-longtitle="true"></div>
</div>
<div class="form-group">
<div id="Gerror"></div>
</div>
<legend>Login:</legend>
<!-- <a href="#" onclick="signOut();">Sign out</a> -->
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
<script>
$(function(){
	$("#header").load("../header.jsp");
});//end of ready
// 	function onSignIn(googleUser) {
// 		var profile = googleUser.getBasicProfile();
// 		var id_token = googleUser.getAuthResponse().id_token;
		
// 		console.log('profile: ' + profile);
// 		console.log('id_token: ' + id_token);
// 		console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
// 		console.log('Name: ' + profile.getName());
// 		console.log('Given Name: ' + profile.getGivenName());
// 		console.log('Family Name: ' + profile.getFamilyName());
// 		console.log('Image URL: ' + profile.getImageUrl());
// 		console.log('Email: ' + profile.getEmail());
// 		console.log('===========================================');
// 	}

// 	function signOut() {
// 		var auth2 = gapi.auth2.getAuthInstance();
// 		auth2.signOut().then(function() {
// 			console.log('User signed out.');
// 		});
// 	}
</script>
<script>
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
			window.location = "<%=from%>";
		}else if(responseText == "AccountExist"){
			gapi.auth2.getAuthInstance().signOut().then(function() {
				console.log('User signed out.');
			});
			$("#Gerror").empty();
			$("#Gerror").append( "<p style='color:red'>connecting error please try other method.</p>" );
		}else if(responseText == "GSignAndLoginSuccess"){
			console.log(responseText);
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
		}
	});
}
</script>
</body>
</html>