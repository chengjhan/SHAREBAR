<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<title>Profile Page</title>
<script type="text/javascript">
$(function(){
	$("#header").load("../header.jsp");
	
	//follow item function
	$('div.box').hover(over);
	var change = $(this);
	function over(){
		if(($(this).find('a.followerimg').attr("following")) == 1){
			$(this).find('a.followerimg').toggleClass('btn-danger');	
		}
	}
	
	//追隨按鈕
	$("p > a").click(function(){
		var change = $(this);
		var itemid = change.attr("value");
	$.get("followItem.do",{"MemberID":"${user.member_no}","ItemID":$(this).attr("value")},
			
			function(data){
					change.attr("following",data);
					change.toggleClass("btn-danger");
				})
		
	})
});
</script>
<style>
#basic_info{
	top:150px;
	padding:10px;
}

#basic_info>.row{ 
/* 	display: table;  */
	display: flex;
 } 
#basic_info>.row>[class*='col-']{
 	display: table-cell;
 	float: none; 
	vertical-align:center;
	flex: 1; /* additionally, equal width */
	padding: 1em;
	border: solid;
	horizontal-align:center;
}
img.follow_list{
	width:100%;
	height:100%;
}
img#user_photo{
	width:200px;
	height:200px;
}
div.img_container{
	width: 100px;
    height: 150px;
    padding: 0px;
    border:1px solid gray;  /* you can remove this */
    box-sizing:border-box; /* you can remove this */
    display:inline-block;
}

/* XD */
.textellipsis{
	 text-overflow:ellipsis;
	 overflow:hidden;
	 white-space: nowrap;
}


	
	/* 快速追蹤按鈕 顯示*/
.box:hover .btn{display:block;}
.box .btn{display:none;}
	
.followerimg{
 	float:right; 
	position: relative;
	right: 0px;
	bottom: 30px;
/* 	height: 30px; */
}



</style>
</head>
<body>
<%@ page import="member.model.MemberBean"%>
<%@ page import="java.util.*"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<c:url value="/" var="root"></c:url>
<%

%>
<div id="header"></div>
<div class="container" id="basic_info">
<div class="row" id="basic_info_row">
<div class="col-md-2 col-sm-2 col-xs-2" id="photo_div">
<img class="img-rounded" id="user_photo" alt='user_photo' src='${root}profileImages/${user.photo}' width="100%" height="100%"/>
<c:if test="${user.certification eq 1}">
<!-- <div id="email_certi"><p>certification</p></div> -->
<div><img id="email_certi" src="${root}/certificationPhoto/Accept-32.png" width="16" height="16">certification</div>
</c:if>
</div>
<div class="col-md-2 col-sm-2 col-xs-2" id="profile_button">
<a class="btn btn-default" href="<c:url value='/member/changeInfo.jsp'/>">Edit</a>
</div>
<div class="col-md-2 col-sm-2 col-xs-2" id="info_div" style="vertical-align:top">
<h1>${user.nickname}</h1>
<span class="glyphicon glyphicon-file"></span>Self-introduction: <p>${user.description}</p>
<span class="glyphicon glyphicon-home"></span>Hometown<p>${user.country} : ${user.city}</p>
</div>
<div class="col-md-6 col-sm-6 col-xs-6" id="review_div">

</div>
</div><!-- end of row basic info-->

<hr>

</div><!-- end of basic_info -->
<div class="container" id="other_info">

<ul class="nav nav-tabs">
<li class="active"><a data-toggle="tab" href="#items">Items</a></li>
<li><a data-toggle="tab" href="#follow">Follow</a></li>
<li><a data-toggle="tab" href="#followed">Followed</a></li>
<li><a data-toggle="tab" href="#followitems">FolloweItems</a></li>
</ul>
	<div class="tab-content">
	
	<div id="items" class="tab-pane fade in active">
    	<!-- show follow list -->
		<div class="row">
		<c:forEach var="item" items="${user.member_items}">
		<div class="col-md-2 col-sm-2 col-xs-4">
		<div class="thumbnail">
		<a href="${root}item/itemdetail.controller?id=${item.item_id}">
		<c:forEach var="image" items="${item.imageBean}" varStatus="stat">
			<c:if test="${stat.first}">
				<div class="img_container">
					<img alt="item_image" src="${root}item-image/${image.image_photo}" class="follow_list">
				</div>
			</c:if>
		</c:forEach>
		<div class="caption">
		<p class="textellipsis">Itemname:${item.item_name}ItemID:${item.item_id}:${item.member_id.nickname}</p>
		</div>
		</a>
		</div>
		</div><!-- end of col-md-2 -->
		</c:forEach>
		</div><!-- end of row -->
    </div><!-- end of items -->
    
	<div id="follow" class="tab-pane fade">
		<!-- show follow list -->
		<div class="row">
		<c:forEach var="follow" items="${userFollow}">
		<c:if test="${follow.relation == 'follow'}">
		<div class="col-md-2 col-sm-2 col-xs-4">
		<div class="thumbnail">
		<a href="${root}member/profile.controller?id=${follow.member_followed.member_no}">
		<div class="img_container">
		<img alt="${follow.member_followed.nickname}" src="${root}profileImages/${follow.member_followed.photo}" class="follow_list">
		</div>
		<div class="caption">
		<p class="textellipsis">${follow.member_followed.nickname}:${follow.member_followed.member_no}:${follow.relation}</p>
		</div>
		</a>
		</div>
		</div><!-- end of col-md-2 -->
		</c:if>
		</c:forEach>
		</div><!-- end of row -->
		<!-- end of show follow list -->
    </div>
    
    <div id="followed" class="tab-pane fade">
		<!-- show follow list -->
		<div class="row">
		<c:forEach var="followed" items="${userFollowed}">
		<c:if test="${followed.relation == 'follow'}">
		<div class="col-md-2 col-sm-2 col-xs-4">
		<div class="thumbnail">
		<a href="${root}member/profile.controller?id=${followed.member_follow.member_no}">
		<div class="img_container">
		<img alt="${followed.member_follow.nickname}" src="${root}profileImages/${followed.member_follow.photo}" class="follow_list">
		</div>
		<div class="caption">
		<p class="textellipsis">${followed.member_follow.nickname}:${followed.member_followed.member_no}:${followed.relation}</p>
		</div>
		</a>
		</div>
		</div><!-- end of col-md-2 -->
		</c:if>
		</c:forEach>
		</div><!-- end of row -->
		<!-- end of show follow list -->
    </div>
    
    <div id="followitems" class="tab-pane fade">
		<!-- show follow list -->
		<div class="row">
		<c:forEach var="followitems" items="${user.follow_items}">
		<c:if test="${followitems.status eq 1}">
		<div class="col-md-2 col-sm-2 col-xs-4">
		<div class="thumbnail box">
		<a href="${root}item/itemdetail.controller?id=${followitems.itemBean.item_id}">
		<c:forEach var="image" items="${followitems.itemBean.imageBean}" varStatus="stat">
			<c:if test="${stat.first}">
				<div class="img_container">
					<img alt="${followitems.itemBean.item_name}" src="${root}item-image/${image.image_photo}" class="follow_list">
				</div>
			</c:if>
		</c:forEach>
		<div class="caption">
		<p class="textellipsis">${followitems.itemBean.item_name}</p>
		</div>
		</a>
		<p><!-- 	追蹤按鈕		 -->
		<a class="btn btn-default followerimg" value="${followitems.itemBean.item_id}" following="${followitems.status}" >
		<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
		</a>
		</p><!-- 	追蹤按鈕		 -->
		</div>	
		</div><!-- end of col-md-2 -->			
		</c:if>
		</c:forEach>
		</div><!-- end of row -->
	</div><!-- end of show follow list -->

</div><!-- end of tab content -->
</div>
<script>

</script>
</body>
</html>
