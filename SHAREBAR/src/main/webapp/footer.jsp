<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
/* div#id_footer { */
/*     /* 設定footer的高度 */ */
/*     height: 50px; */
/*     /* 設定footer絕對位置在底部 */ */
/*     position: fixed; */
/*     bottom: 0; */
/*     /* 展開footer寬度 */ */
/*     width: 100%; */
/*     text-align:center; */
/*     background-color:#E6E6E6; */
/*     vertical-align:center; */
}
#id_footer{
	width:100%;
	text-align:center;
	position: fixed;
    bottom: 0;
    height: 50px;
    background-color:#E6E6E6;
}
</style>
</head>
<body>
<footer id="id_footer">
<div>
<a href="<c:url value='/index.jsp'/>">CONTACT US</a></a>
</div>
</footer>
</body>
</html>