<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel=stylesheet type="text/css" href="css/share.css"> -->

<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/css/font-awesome.css">
<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/css/bootstrap-social.css">

<style>
/*div#id_footer {
    設定footer的高度 	
	height: 50px;
	設定footer絕對位置在底部
	position: fixed;
	bottom: 0;
	展開footer寬度
	width: 100%;
	text-align:center;
	background-color:#E6E6E6;
	vertical-align:center;
}*/
/*#id_test{
	width:100%;
	text-align:center;
	position: fixed;
    bottom: 0;
    height: 50px;
    background-color:#333;
}*/
footer{
	bottom:0;
	right:0;
	left:0;
	height:100%;
	width:100%;
}
</style>
</head>
<body>
<footer> 
<div id="id_footer" class="panel-footer" style="margin-top:30px;background-color:white">
<div class="container-fluid" >
<div class="row">
<div class="col-lg-3 col-sm-3 text-center">
<h4 style="margin:15px 0 20px 0">SUPPORT</h4>
<p><a href="<c:url value='/index.jsp'/>">Contant us</a></p>
<p><a href="<c:url value='/index.jsp'/>">Donate us</a></p>
</div>
<div class="col-lg-3 col-sm-3 text-center">
<h4 style="margin:15px 0 20px 0">MORE ABOUT US</h4>
<div>
<p><a href="<c:url value='/index.jsp'/>">Our team</a></p>
<p><a href="<c:url value='/index.jsp'/>">Train from</a></p>
</div>
</div>
<div class="col-lg-3 col-sm-3 text-center">
<h4 style="margin:15px 0 20px 0">FOLLOW US ON</h4>
<div>
<p><a href="<c:url value='/index.jsp'/>">Facebook</a></p>
<p><a href="<c:url value='/index.jsp'/>">Instagram</a></p>
</div>
</div>
<div class="col-lg-3 col-sm-3 hidden-xs text-center">
<img src="<c:url value='/img/SHAREBAR.png'/>" style="position:relative;height: 114px; width:114px;">
</div>
</div>
</div>
</div>
<div class="panel-footer" style="background-color:#98c1d9;height:60px;">
<div class="container">
<div class="pull-left">
Copyright 2017 © 
<strong>SHAREBAR TEAM</strong>
</div>
<div class="pull-right">
<a class="btn btn-social-icon btn-vk" data-toggle="tooltip" data-placement="top" title="Send us an e-mail" style="margin-right:3px" onclick="_gaq.push(['_trackEvent', 'btn-social-icon', 'click', 'btn-facebook']);"><span class="fa fa-envelope "></span></a>
<a class="btn btn-social-icon btn-facebook" data-toggle="tooltip" data-placement="top" title="Follow us on facebook" style="margin-right:3px" onclick="_gaq.push(['_trackEvent', 'btn-social-icon', 'click', 'btn-facebook']);"><span class="fa fa-facebook"></span></a>
<a class="btn btn-social-icon btn-instagram" data-toggle="tooltip" data-placement="top" title="Follow us on instagram" style="margin-right:3px" onclick="_gaq.push(['_trackEvent', 'btn-social-icon', 'click', 'btn-facebook']);"><span class="fa fa-instagram "></span></a>
</div>
</div>
</div>
</footer>
<script type="text/javascript">
$(function(){
	 $('[data-toggle="tooltip"]').tooltip();  
})
</script>
</body>
</html>