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

<link rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css">
<script src="../js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>

<title>Profile Page</title>
<script type="text/javascript">
$(function(){
	$("#header").load("../header.jsp");
	
	//判斷是否追蹤

	var member_no = ${user.member_no};
	var itemid = ${itembean.item_id};
	var itemstatus = 0;
	
	$.get("<%=request.getContextPath()%>/followitems/itemStatus.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}"},
			function(data){
		itemstatus = data;
		if(itemstatus==1){
			$('input[value="追蹤按鈕"]').attr("value","取消追蹤");
			$('input[value="追蹤按鈕"]').toggleClass("btn-danger");
		}
	})
	
	//追隨按鈕
	$('input[value="追蹤按鈕"]').click(function(){
		var change = $(this);
		var itemid = change.attr("value");
	$.post("followItem.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}"},
			
			function(data){
					change.attr("following",data);
					change.toggleClass("btn-danger");
					if(data==1){
						change.attr("value","取消追蹤")	
					}
					else{change.attr("value","追蹤按鈕")}
				})
	})
	//切換圖片功能
	var showpic =null;
	$(".item_pic").click(function(){
		if(!$("#showpic").is(":animated")){
			showpic=$(this).attr("src");
			showpic2=$("#showpic").attr("src");
			$("#showpic2").attr("src",showpic2);
			$("#showpic").attr("src",showpic);
			$("#showpic").effect( "slide", "200" );
		}
	})
	
	
	//留言websocket
	var webSocket = null;
	function initwebsocket(){
		webSocket = new WebSocket('ws://localhost:8080/SHAREBAR/item/MessageBoardWebSocket');

		webSocket.onopen = function(evt){
			onOpen(evt);
		};
		webSocket.onclose = function(evt){
			onClose(evt);
		}
		webSocket.onmessage = function(evt){
			onMessage(evt.data);
		}
		webSocket.onerror = function(evt){
			onError(evt);
		}
	}
	
	initwebsocket();
	
	function onOpen(evt){
	}
	function onClose(evt){
		alert("websocket close")
	}
	function onMessage(evt){
	var messagecontain = JSON.parse(evt);
	var item_id = messagecontain.item_id;
	var member_no = messagecontain.member_no;
	var message = messagecontain.message;
	var photo = messagecontain.photo;
	var nickname = messagecontain.nickname;
	$('#endline').before(
			'<li style="margin-bottom:15px; margin-top:10px" class="newmessage">'+
	    	'<a href="${root}member/profile.controller?id='+member_no+'"'+ 'class="pull-left">'+
	    	'<div>'+
	    	'<img class="img-circle" src="/SHAREBAR/profileImages/'+ photo+ '" style="width:32px;height:32px;margin-right:15px; ">'+
	    	'</div>'+
	    	'</a>'+
	    	'<strong>'+nickname+'</strong>'+
	    	'<time>${message.time}</time>'+
	    	'<p style="overflow: hidden;">'+message+'</span>'+
	    	'</li>'
			)
	$('.newmessage').show(400);		
	}
	function onError(evt){
	}
	
	//留言版功能
	$('#sendmessage').click(function(){
// 		alert("click");
	var message = $("#messageboard").val();
	var photo ="${user.photo}";
	var nickname = "${user.nickname}";
	
	
	
	$.post("messageBoard.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}","message":message},
			function(data){
		webSocket.send(JSON.stringify({
			item_id:itemid,
			member_no:member_no,
			message:message,
			photo:photo,
			nickname:nickname
			}))
	});	
	
// 	alert("留言成功");
	$("#messageboard").val("");
		
	});
	
});
</script>
<style>
#basic_info{
	top:100px;
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
}
#follow_button{
	width: 100%;
}
.show_pic{
	width: 420px;
	height:420px;
	margin:15px;
}
.finger{
	cursor:pointer;
}
.newmessage{
	display:none;
}

/* .item_pic{ */
/* 	cursor: pointer; */
/* } */


/* #info_div>[class*='col-']{ */

/* } */
/* .follow_list>img{ */
/* 	width:155; */
/* 	height:155; */
/* } */

/*XD*/
time{
	margin-left: 10px;
	font-size: small;
	color: gray;
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
<div class="col-md-8" id="photo_div">
	<div class="row">
	<div class="col-md-9" >
	<c:forEach var="image" items="${itembean.imageBean}" varStatus="stat">
		<c:if test="${stat.first}">
				<img class="show_pic" id="showpic" alt="item_image" src="${root}item-image/${image.image_photo}" style="z-index:2;position:absolute">
				<img class="show_pic" id="showpic2" alt="item_image" src="${root}item-image/${image.image_photo}" style="z-index:1;top:0;left:15px;">
		</c:if>
	</c:forEach>
	
	</div>
	<%--   功能按鈕      --%>

	<div class="col-md-3">
	<div >
	<c:choose>
	<c:when test="${itembean.member_id.member_no eq user.member_no}">
	<input type="button" value="Edit" class="btn btn-primary">
	</c:when>
	<c:otherwise>
	<input type="button" value="私訊分享者" class="btn btn-primary" style="margin :15px">
	<input type="button" value="追蹤按鈕" class="btn btn-success" style="width:80px;margin :15px" >
	<input type="button" value="檢舉商品" class="btn btn-default" style="margin :15px">
	</c:otherwise>
	</c:choose>
	</div>
	</div>

<%--   功能按鈕      --%>
	</div>
	<div class="row">
	<c:forEach var="image" items="${itembean.imageBean}" varStatus="stat">
<%-- 		<c:if test="${stat.first}"> --%>
			<div class="col-md-2 col-sm-3 col-xs-3 finger">
				<img class="item_pic thumbnail" alt="item_image" src="${root}item-image/${image.image_photo}" width="80" height="80">
			</div>
<%-- 		</c:if> --%>
	</c:forEach>
	</div>
</div>


<div class="col-md-4" id="info_div" style="vertical-align:top">
<h1>${member.nickname}</h1>
<span class="glyphicon glyphicon-file"></span>分享物品: <p>${itembean.item_name}</p>
<span class="glyphicon glyphicon-map-marker"></span>地點:<p>${itembean.location}</p>


</div>

</div><!-- end of row basic info-->
<hr>
</div><!-- end of basic_info -->

<div class="row">
<div class="container">
<div class="col-md-8" id="other-info">
<ul class="nav nav-tabs">
<li class="active"><a data-toggle="tab" href="#descrption">分享描述</a></li>
<li><a data-toggle="tab" href="#message">討論</a></li>
</ul>

	<div class="tab-content">
	<div id="descrption" class="tab-pane fade in active">
    	<div class="row">
    	<span class="glyphicon glyphicon-tag"></span>說明:<p>${itembean.item_description}</p>
    	 </div>
    </div>
    <div id="message" class="tab-pane fade" style="padding:10px 0">
    	<ul style="padding-left: 0 ; list-style-type:none;">
    	<c:forEach var="message" items="${itembean.messageboard}" varStatus="stat">
    	<li style="display: list-item;margin-bottom:15px; margin-top:10px">
    	<a href="${root}member/profile.controller?id=${message.member_id.member_no}" class="pull-left">
    	<div>
    	<img class="img-circle" src="${root}profileImages/${message.member_id.photo}" style="width:32px;height:32px;margin-right:15px; ">
    	</div>
    	</a>
    	<strong>${message.member_id.nickname}</strong>
    	<time></time>
    	<p style="overflow: hidden;">${message.message}</span>
    	</li>
    	</c:forEach>
    	<p id="endline"/>
    	</ul>
    	<textarea id="messageboard" class="form-control" style="margin:15px 0" placeholder="請輸入留言訊息"></textarea>
    	<input id="sendmessage" class="pull-right btn btn-default" type="button" value="留言" style="width:100px">
    </div>
  </div>
</div>
<div id="other-info">
<h3 class="text-center" style="margin:5px 0px 20px 0px">
<span >分享者資訊</span>
</h3>
	<div class="col-md-4 alert alert-info" role="alert" style="">	
	<div class="row">
	<div class="col-md-7 col-md-7 col-xs-4">
	<a href="${root}member/profile.controller?id=${itembean.member_id.member_no}" class="alert-link">
	<img alt="${follow.member_followed.nickname}" src="${root}profileImages/${itembean.member_id.photo}" class="img-rounded" width="155" height="155">
	</a>
	</div>
	<div class="col-md-5 col-sm-5 col-xs-8">
	<h1>${itembean.member_id.nickname}</h1>
	<span class="glyphicon glyphicon-home"></span>Hometown<p>${itembean.member_id.country} : ${itembean.member_id.city}</p>
	</div>
	
	</div>
	</div>
</div>
</div>
</div>

<script type="text/javascript">
$("#follow_button").click(function(){
	var status = $(this).val;
});//end of click
</script>
</body>
</html>
