<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root"></c:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<%

session.invalidate();
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0);

%>
<body onload="noBack();"
    onpageshow="if (event.persisted) noBack();" onunload="">
	<h1>you have log out already</h1>
	<script type="text/javascript">
		function noBack() { window.history.forward(); }
		setTimeout(function() {
			window.location = "${root}";
		}, 500);
	</script>

</body>
</html>