<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="../js/jquery-ui-1.12.1.custom/jquery-ui.min.js">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<title>Profile Page</title>
<script type="text/javascript">
$(function(){
	$("#header").load("../header.jsp");
	
	//判斷是否追蹤
// 	var memberid = ${user.member_no};
	var itemid = ${itembean.item_id}
	var itemstatus = 0;
	
	$.get("<%=request.getContextPath()%>/followitems/itemStatus.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}"},
			function(data){
		itemstatus = data;
		if(itemstatus==1){
			$("div>input:eq(1)").attr("value","已追蹤");
			$("div>input:eq(1)").toggleClass("btn-success");
		}
	})
	
	//追隨按鈕
	$("div>input:eq(1)").click(function(){
		var change = $(this);
		var itemid = change.attr("value");
	$.post("followItem.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}"},
			
			function(data){
					change.attr("following",data);
					change.toggleClass("btn-success");
					if(data==1){
						change.attr("value","已追蹤")	
					}
					else{change.attr("value","追蹤按鈕")}
				})
	})
	
	
});
</script>
<style>
#basic_info{
	top:100px;
	padding:10px;
}

#basic_info>.row{ 
	display: table; 
 } 
#basic_info>.row>[class*='col-']{
	display: table-cell;
	float: none;
	vertical-align:center;
}
#follow_button{
	width: 100%;
}

/* #info_div>[class*='col-']{ */

/* } */
/* .follow_list>img{ */
/* 	width:155; */
/* 	height:155; */
/* } */
</style>
</head>
<body>
<%@ page import="member.model.MemberBean"%>
<%@ page import="java.util.*"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<c:url value="/" var="root"></c:url>
<div id="header"></div>
<div class="container" id="basic_info">
<div class="row">
<div class="col-md-8" id="photo_div">
	<c:forEach var="image" items="${itembean.imageBean}" varStatus="stat">
		<c:if test="${stat.first}">
			<div class="img_container">
				<img alt="item_image" src="${root}item-image/${image.image_photo}" width="200" height="200">
			</div>
		</c:if>
	</c:forEach>
</div>
<div class="col-md-4" id="info_div" style="vertical-align:top">
<h1>${member.nickname}</h1>
<span class="glyphicon glyphicon-file"></span>分享物品: <p>${itembean.item_name}</p>
<span class="glyphicon glyphicon-map-marker"></span>地點:<p>${itembean.location}</p>
<span class="glyphicon glyphicon-tag"></span>說明:<p>${itembean.item_description}</p>
<div>
<c:choose>
<c:when test="${itembean.member_id.member_no eq user.member_no}">
<input type="button" value="Edit" class="btn btn-primary">
</c:when>
<c:otherwise>
<input type="button" value="私訊分享者" class="btn btn-primary">
<input type="button" value="追蹤按鈕" class="btn btn-default" style="width:80px;">
<input type="button" value="檢舉商品" class="btn btn-default">
</c:otherwise>
</c:choose>
</div>
</div>
</div><!-- end of row basic info-->
</div><!-- end of basic_info -->






<!-- <div class="container" id="other_info"> -->
	<div class="tab-content">
    <div class="row">
    <div class="">
    
    </div>
<!--       <h3>Itembeam資訊</h3> -->
<%--       <p> itemid: ${itembean.item_id}</p> --%>
<%--       <p> itemname: ${itembean.item_id}</p> --%>
<%--       <p> item discription: ${itembean.item_discription}</p> --%>
<%--       <p> item location: ${itembean.location}</p> --%>
<%--       <p> item done: ${itembean.done}</p> --%>
<!--       <p> 分享者資訊</p> -->
<%--       <p> itembean: ${itembean.itemMemberbean}</p> --%>
<%--       <p> 分享者編號: ${itembean.itemMemberbean.member_no}</p> --%>
<%--       <p> 分享者名稱: ${itembean.itemMemberbean.nickname}</p> --%>
<%--       <p> 分享者居住地方: ${itembean.itemMemberbean.city}</p> --%>
      
<!--     </div> -->
  </div>
</div>
<script type="text/javascript">
$("#follow_button").click(function(){
	var status = $(this).val;
});//end of click
</script>
</body>
</html>
