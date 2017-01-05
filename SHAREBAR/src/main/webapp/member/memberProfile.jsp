<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<title>Profile Page</title>
<script type="text/javascript">
$(function(){
	$("#header").load("../header.jsp");
	
	//XD
	$('div.box').hover(over);
	function over(){
		if(($(this).find('a.followerimg').attr("following")) == 1){
			$(this).find('a.followerimg').toggleClass('btn-danger');	
		}
	}
	
	//追隨按鈕
	$("p > a").click(function(){
		var change = $(this);
		var itemid = change.attr("value");
		if(Number("${user.member_no}") == ""){
			location.assign('http://localhost:8080/SHAREBAR/secure/login.jsp');
		}
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
/* 	vertical-align:center; */
	flex: 1; /* additionally, equal width */
	padding: 1em;
/* 	border: solid; */
	horizontal-align:center;
	text-align:center;
}
img.follow_list{
	width:100%;
	height:100%;
}
img#user_photo{
	width:200px;
	height:200px;
	margin: auto auto;
}
div.img_container{
	width: 100%;
    padding: 0px;
    border:1px solid #ffffff;  /* you can remove this */
    box-sizing:border-box; /* you can remove this */
    display:inline-block;
}

div#review_div{
	background-color:#FFFFFF;
	border: 2px solid #F2F2F2;
	border-radius: 16px!important;
}

.review_class{
	word-wrap:break-word;
	padding:3px;
	margin:5px auto;
	width:100%;
	height:65px;
}

.review_img_div{
	height:100%;
}

.review_img{
	float: left;
    margin: 5px 5px;
}
div#review_sum_div{
	top: 5px;
    right: 5px;
    width: 35%;
    height: 20px;
    position: absolute;
    background-color: #f5f5f5;
    text-align: right;
        
}
.showpoint{
	display:inline;
	margin:auto 3px;
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
}


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
<div class="col-md-6 col-sm-6 col-xs-12" id="photo_div">
<img class="img-rounded" alt='member_photo' src='${root}profileImages/${member.photo}' width="200" height="200"/>
<c:if test="${member.certification eq 1}">
<div><img id="email_certi" src="${root}/certificationPhoto/Accept-32.png" width="16" height="16">certification</div>
</c:if>
</div>

<div class="col-md-6 col-sm-6 col-xs-12" id="info_div" style="vertical-align:top">
<h1>${member.nickname}</h1>
<span class="glyphicon glyphicon-file"></span>Self-introduction: <p>${member.description}</p>
<span class="glyphicon glyphicon-home"></span>Hometown<p>${member.country} : ${member.city}</p>
<div>
<c:choose>
<c:when test="${user2check eq 'follow'}"><input id="follow_button" type="button" class="btn btn-danger" follow_status="follow" value="unfollow" member_no="${member.member_no }" style="width:100px"></c:when>
<c:when test="${user2check eq 'unfollow'}"><input id="follow_button" type="button" class="btn btn-default" follow_status="unfollow" value="follow" member_no="${member.member_no }" style="width:100px"></c:when>
</c:choose>
</div>
</div>
</div><!-- end of row basic info-->
</div><!-- end of basic_info -->
<hr>
<div class="container" id="other_info">
<div class="row">
<div id="review_div_col" class="col-md-3 col-sm-3 col-xs-12">
<div id="review_sum_div"><span id="show_good_span" class="glyphicon glyphicon-thumbs-up"></span>  <span id="show_normal_span" class="glyphicon glyphicon-minus"></span>  <span id="show_bad_span" class="glyphicon glyphicon-thumbs-down"></span></div>
<fieldset>
<legend>Reviews</legend>
<ul class="nav nav-tabs">
<li class="active"><a data-toggle="tab" href="#Share">Share</a></li>
<li><a data-toggle="tab" href="#Get">Get</a></li>
</ul>
<div class="tab-content">
<div id="Share" class="tab-pane fade in active"></div>
<div id="Get" class="tab-pane fade in"></div>
</div><!-- end of tab-content -->
</fieldset>
</div>
<div id="member_content_col" class="col-md-9 col-sm-9 col-xs-12">
<ul class="nav nav-tabs">
<li class="active"><a data-toggle="tab" href="#items">Items</a></li>
<li><a data-toggle="tab" href="#follow">Follow</a></li>
<li><a data-toggle="tab" href="#followed">Followed</a></li>
</ul>
	<div class="tab-content">
	
    <div id="items" class="tab-pane fade in active">
      	<div class="row">
		<c:forEach var="item" items="${member.member_items}">
		<div class="col-md-2 col-sm-3 col-xs-4">
		<div class="thumbnail box">
		<a href="${root}item/itemdetail.controller?id=${item.item_id}">
		<c:forEach var="image" items="${item.imageBean}" varStatus="stat">
			<c:if test="${stat.first}">
				<div class="img_container">
					<img alt="item_image" src="${root}item-image/${image.image_photo}" class="follow_list">
				</div>
			</c:if>
		</c:forEach>
		<div class="caption">
		<p class="textellipsis">${item.item_name}:${item.item_id}:${item.member_id.nickname}</p>
		</div>
		</a>
		<p><!-- 	追蹤按鈕		 -->
		<a class="btn btn-default followerimg" value="${item.item_id}" following="
		<c:forEach var="relation" items="${item.follow_items}">
		<c:if test="${relation.member_id.member_no eq user.member_no}">
		<c:if test="${relation.status == '1' }">
		1
		</c:if>
		</c:if>
		</c:forEach>
		" >
		<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
		</a>
		</p><!-- 	追蹤按鈕		 -->
		</div>
		</div><!-- end of col-md-2 -->
		</c:forEach>
		</div><!-- end of row -->
    </div>
    
	<div id="follow" class="tab-pane fade">
		<div class="row"> <!-- show follow list -->
		<c:forEach var="follow" items="${memberFollow}">
		<c:if test="${follow.relation == 'follow'}">
		<div class="col-md-2 col-sm-3 col-xs-4">
		<div class="thumbnail">
		<a href="${root}member/profile.controller?id=${follow.member_followed.member_no}">
		<div class="img_container">
		<img alt="${follow.member_followed.nickname}" src="${root}profileImages/${follow.member_followed.photo}" class="follow_list" width="155" height="155">
		</div>
		<div class="caption">
		<p>${follow.member_followed.nickname}:${follow.member_followed.member_no}</p>
		</div>
		</a>
		</div>
		</div><!-- end of col-md-2 -->
		</c:if>
		</c:forEach>
		</div><!-- end of row --> <!-- end of show follow list -->
    </div>
    
    <div id="followed" class="tab-pane fade">
		<!-- show follow list -->
		<div class="row">
		<c:forEach var="followed" items="${memberFollowed}">
		<c:if test="${followed.relation == 'follow'}">
		<div class="col-md-2 col-sm-3 col-xs-4">
		<div class="thumbnail">
		<a href="${root}member/profile.controller?id=${followed.member_follow.member_no}">
		<div class="img_container">
		<img alt="${followed.member_follow.nickname}" src="${root}profileImages/${followed.member_follow.photo}" class="follow_list" width="155" height="155">
		</div>
		<div class="caption">
		<p>${followed.member_follow.nickname}:${followed.member_follow.member_no}</p>
		</div>
		</a>
		</div>
		</div><!-- end of col-md-2 -->
		</c:if>
		</c:forEach>
		</div><!-- end of row -->
		<!-- end of show follow list -->
    </div>
  </div><!-- end of tab content -->
  </div><!-- end of tab content col -->
</div><!-- end of #other_info.row -->
</div><!-- end of other_info -->
<script type="text/javascript">
$("#follow_button").click(function(){
	var button = $(this);
	var status = button.attr("follow_status");
	var member_no = button.attr("member_no");
	console.log("follow status: "+status);
	console.log("member no: "+member_no);
	if(status == "follow"){
		$.post("FollowChange.do",{"id":member_no,"status":status},function(data){
			if(data == "success"){
				console.log("success");
				button.attr("follow_status","unfollow");
				button.val("follow");
				button.attr("class","btn btn-default");
			}else{
				console.log("fail");
			}
		});//end of get
	}
	if(status == "unfollow"){
		$.post("FollowChange.do",{"id":member_no,"status":status},function(data){
			if(data == "success"){
				console.log("success");
				button.attr("follow_status","follow");
				button.val("unfollow");
				button.attr("class","btn btn-danger");
			}else if(data == "nonLogin"){
				alert("you have to login first!");
			}
		});//end of get
	}
});//end of click
var asgiverReviews = JSON.parse('<%=request.getAttribute("memberasGiver")%>');
var asgetterReviews = JSON.parse('<%= request.getAttribute("memberasGetter")%>');
var goodpoint = asgiverReviews.good + asgetterReviews.good;
var normalpoint = asgiverReviews.normal + asgetterReviews.normal;
var badpoint = asgiverReviews.bad + asgetterReviews.bad;
$("#show_good_span").append("<p class='showpoint'>"+goodpoint+"</p>");
$("#show_normal_span").append("<p class='showpoint'>"+normalpoint+"</p>");
$("#show_bad_span").append("<p class='showpoint'>"+badpoint+"</p>");
if(asgiverReviews.Count != 0){
	$.each(asgiverReviews.giverReviews,function(index,giverReview){
		var getterId = giverReview.getterID;
		var getterPhoto = giverReview.getterPhoto;
		var myRate = giverReview.giverRate;
		var myReview = giverReview.giverReview;
//	 	console.log(giverId+" "+giverPhoto+" "+myRate+" "+myReview);
		if(myRate==3){
		$("div#Share").append(
				"<div class='review_class' style='background-color:#CFF6D0'>"
				+"<a href='${root}member/profile.controller?id="+getterId+"' class='pull-left'>"
				+"<div class='review_img_div' >"
				+"<img class='review_img' src='/SHAREBAR/profileImages/"+getterPhoto+"' height='40px'/>"
				+"</div>"
				+"</a>"
				+myReview
				+"</div>"
				);
		}else if(myRate==2){
			$("div#Share").append(
					"<div class='review_class' style='background-color:#F2F2F2'>"
					+"<a href='${root}member/profile.controller?id="+getterId+"' class='pull-left'>"
					+"<div class='review_img_div' >"
					+"<img class='review_img' src='/SHAREBAR/profileImages/"+getterPhoto+"' height='40px'/>"
					+"</div>"
					+"</a>"
					+myReview
					+"</div>"
					);
		}else if(myRate==1){
			$("div#Share").append(
					"<div class='review_class' style='background-color:#F5BAAC'>"
					+"<a href='${root}member/profile.controller?id="+getterId+"' class='pull-left'>"
					+"<div class='review_img_div' >"
					+"<img class='review_img' src='/SHAREBAR/profileImages/"+getterPhoto+"' height='40px'/>"
					+"</div>"
					+"</a>"
					+myReview
					+"</div>"
					);
		}
	});//end of each
	}else if(asgiverReviews.Count == 0){
		$("div#Share").append(
				"<div class='review_class' style='background-color:#FFFFFF'>"
				+"<p>"
				+"no comment...."
				+"</p>"
				+"</div>"
		);
	}
if(asgetterReviews.Count != 0){
$.each(asgetterReviews.getterReviews,function(index,getterReview){
	var giverId = getterReview.giverID;
	var giverPhoto = getterReview.giverPhoto;
	var myRate = getterReview.getterRate;
	var myReview = getterReview.getterReview;
// 	console.log(giverId+" "+giverPhoto+" "+myRate+" "+myReview);
	if(myRate==3){
	$("div#Get").append(
			"<div class='review_class' style='background-color:#CFF6D0'>"
			+"<a href='${root}member/profile.controller?id="+giverId+"' class='pull-left'>"
			+"<div class='review_img_div' >"
			+"<img class='review_img' src='/SHAREBAR/profileImages/"+giverPhoto+"' height='40px'/>"
			+"</div>"
			+"</a>"
			+myReview
			+"</div>"
			);
	}else if(myRate==2){
		$("div#Get").append(
				"<div class='review_class' style='background-color:#F2F2F2'>"
				+"<a href='${root}member/profile.controller?id="+giverId+"' class='pull-left'>"
				+"<div class='review_img_div' >"
				+"<img class='review_img' src='/SHAREBAR/profileImages/"+giverPhoto+"' height='40px'/>"
				+"</div>"
				+"</a>"
				+myReview
				+"</div>"
				);
	}else if(myRate==1){
		$("div#Get").append(
				"<div class='review_class' style='background-color:#F5BAAC'>"
				+"<a href='${root}member/profile.controller?id="+giverId+"' class='pull-left'>"
				+"<div class='review_img_div' >"
				+"<img class='review_img' src='/SHAREBAR/profileImages/"+giverPhoto+"' height='40px'/>"
				+"</div>"
				+"</a>"
				+myReview
				+"</div>"
				);
	}
});//end of each
}else if(asgetterReviews.Count == 0){
	$("div#Get").append(
			"<div class='review_class' style='background-color:#FFFFFF'>"
			+"<p>"
			+"no comment...."
			+"</p>"
			+"</div>"
	);
}
</script>
</body>
</html>
