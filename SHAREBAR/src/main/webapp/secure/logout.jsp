<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root"></c:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	session.invalidate();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- GSignIn -->
<meta name="google-signin-client_id"
	content="113677232132-der9mtb9vq1bi5j7aj56k99bcvhj1kj2.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js?onload=onLoad" async
	defer></script>
<!-- GSignIn -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<title>Logout</title>
</head>
<body>
	<h1>you have log out already</h1>
	<script type="text/javascript">
		// 		function onLoad() {
		// 			gapi.load('auth2', function() {
		// 				gapi.auth2.init();
		// 			});
		// 		}
		// 		$(function() {
		// 			if (gapi.auth2.getAuthInstance()) {
		// 				setTimeout(
		// 						function() {
		// 							var auth2 = gapi.auth2.getAuthInstance();
		// 							auth2.signOut().then(function() {
		// 								console.log('User signed out.');
		// 							});
		// 							window.location = "http://localhost:8080/SHAREBAR/index.jsp"
		// 						}, 500);
		// 			}
		// 		});
		setTimeout(function() {
			window.location = "${root}";
		}, 500);
	</script>
</body>
</html>