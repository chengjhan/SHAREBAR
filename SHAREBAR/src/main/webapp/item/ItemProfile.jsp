<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<c:url value='/favicon.ico'/>" type="image/x-icon" />
<link type="text/css" rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="../js/jquery-chatbox/jquery.ui.chatbox.css" />
<link type="text/css" rel="stylesheet" href="../js/bootstrap-dialog/bootstrap-dialog.css" />

<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-chatbox/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script type="text/javascript" src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery-chatbox/jquery.ui.chatbox.js"></script>
<script type="text/javascript" src="../js/jquery-chatbox/chatboxManager.js"></script>
<script type="text/javascript" src="../js/bootstrap-dialog/bootstrap-dialog.js"></script>

<title>SHARE BAR</title>
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
	width: 100%;
 	height:100%;
/* 	margin:15px; */
}
.finger{
	cursor:pointer;
}
.newmessage{
	display:none;
}

.ui-chatbox{
	z-index: 10;
}

.item_pic{
	width: 100%;
	height: 100%;
} 


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
.nav>li:hover{
/* 	background-color: #A9D3FF; */
}

 #followshow.btn-default:hover,#followshow.btn-defaulta:active{   
   	background-color: white;   
 }   
  #followshow.btn-change:hover{   
   	background-color: #c9302c;   
 }  
 
/*  #id_footer{ */
/* 	width:100%; */
/* 	text-align:center; */
/* 	position: fixed; */
/*     bottom: 0; */
/*     height: 50px; */
/*     background-color:#333; */
/* } */
 
</style>
</head>
<body>
<%@ page import="member.model.MemberBean"%>
<%@ page import="java.util.*"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<c:url value="/" var="root"></c:url>
<c:import url="../header.jsp"></c:import>
<div class="container">
<div class="row">
<div class="col-md-7">
<div class="">
	<div class="row">
	<div style="margin-bottom:20px">
	<div  id="picgroup" class="img-rounded" style="position:relative;width:70%;height:70%;margin:0 auto;">
	<span id="prev-btn" class="glyphicon glyphicon-chevron-left finger pull-left" style="position:absolute;font-size:300%;left:0;left:-13%;top:calc(50% - 20px);"></span>
	<span id="next-btn" class="glyphicon glyphicon-chevron-right finger pull-right" style="position:absolute;font-size:300%;right:0;right:-13%;top:calc(50% - 20px);"></span>
	<c:forEach var="image" items="${itembean.imageBean}" varStatus="stat">
		<c:if test="${stat.first}">
			<div class="boxIan">
				<img class="show_pic contentIan" id="showpic" alt="item_image" order="1" src="${root}item-image/${image.image_photo}" style="z-index:2;position:absolute; -webkit-user-select: none;-moz-user-select: none;overflow: hidden;">
				<img class="show_pic contentIan" id="showpic2" alt="item_image" src="${root}item-image/${image.image_photo}" style="z-index:1;position:absolute; -webkit-user-select: none;-moz-user-select: none;overflow: hidden;">
			</div>
		</c:if>
	</c:forEach>
	</div>
	
	</div>

	</div>
	<div class="row">
	<c:forEach var="image" items="${itembean.imageBean}" varStatus="stat">
			<div class="col-md-3 col-sm-3 hidden-xs finger">
			<div class="thumbnail">
			<div class="boxIan">
				<img class="item_pic contentIan" order="${stat.count}" alt="item_image" src="${root}item-image/${image.image_photo}">
			</div>
			</div>
			</div>
	</c:forEach>
	</div>
</div>
</div>


<div class="col-md-5" style="vertical-align:top">
<div class="row share-clean" style="margin-left:0;margin-right:0">
<div class="col-lg-12 col-md-12 col-sm-6" style="margin-top:15px">

<span class="glyphicon glyphicon-user"></span><strong>分享人：</strong>
<a href="${root}member/profile.controller?id=${itembean.member_id.member_no}" class="alert-link">
<p style="margin-left: 15px">${itembean.member_id.nickname}</p>
</a>
<span class="glyphicon glyphicon-gift"></span><strong id="piccount" maxpic="<c:forEach var="test" items="${itembean.imageBean}" varStatus="stat"><c:if test="${stat.last}">${stat.count}</c:if> </c:forEach>">分享物品：</strong>
<p style="margin-left: 15px">${itembean.item_name}</p>
<span class="glyphicon glyphicon-map-marker"></span><strong>地點：</strong>
<p style="margin-left: 15px">${itembean.location}</p>
<strong><hr></strong>

</div>

	<%--   功能按鈕      --%>
	<div class="col-lg-12 col-md-12 col-sm-6 text-center">
	<c:choose>
	<c:when test="${itembean.member_id.member_no eq user.member_no}">
	
	<c:url value="/item/UpdateItem.jsp" var="path">
		<c:param name="item_id" value="${itembean.item_id}" />
		<c:param name="item_name" value="${itembean.item_name}" />
		<c:param name="location" value="${itembean.location}" />
		<c:param name="latitude" value="${itembean.latitude}" />
		<c:param name="longitude" value="${itembean.longitude}" />
		<c:param name="class_name" value="${itembean.classBean.class_name}" />						
		<c:param name="end_date" value="${itembean.end_date}" />
		<c:param name="item_description" value="${itembean.item_description}" />
		<c:forEach var="imageBean" items="${itembean.imageBean}" varStatus="varStatus">
			<c:param name="image_id${varStatus.count}" value="${imageBean.image_id}" />
		</c:forEach>
	</c:url>
	
	<a href="${path}">
		<input type="button" value="Edit" class="btn btn-primary" style="width:100%">
	</a>
	</c:when>
	<c:otherwise>
		<div class="input-group" style="width:100%;">
	   	<input id="followtext" type="button" class="form-control btn btn-default" value="追蹤按鈕	" style="margin :5px 0;height:45px;z-index: 0">
	    <div class="input-group-btn">
	    <button id="followshow" class="btn btn-default" style="height:45px;cursor:auto;z-index:0" >
	    <i class="glyphicon glyphicon-heart">
	    </i></button>
		</div>
		</div>
			<c:if test="${ itembean.done == 0 }">
			<input type="button" id="ask" value="提出分享請求" class="btn btn-success" style="margin :5px 0;width:49%;height:45px">
		</c:if>
		<c:if test="${ itembean.done == 1 && item.getter_id == user_id }">
			<input type="button" id="done" value="成交" class="btn btn-success" style="margin :5px 0;width:49%;height:45px">
		</c:if>
		<c:if test="${ itembean.done == 1 && item.getter_id != user_id }">
			<input type="button" id="done" value="已鎖定" class="btn btn-danger" style="margin :5px 0;width:49%;height:45px">
		</c:if>
	<input type="button" id="report" value="檢舉商品" class="btn btn-danger" style="margin:5px 0;width:49%;height:45px">
			
		
<!-- 	<button value="追蹤按鈕" class="btn btn-default" style="margin:5px 0;width:100%;height:45px" > -->
<!-- 		<span id="followtext" style="display:inline-block;position: relative;top:6px">追蹤按鈕</span> -->
<!-- 		<span id="followshow" style="border-left:inherit;position: relative;width:20%;float: right;height: 43px;top:-5.5px;right:-12px;"> -->
<!-- 		<i class="glyphicon glyphicon-heart" style="top:calc(50% - 8px);"></i> -->
<!-- 		</span> -->
<!-- 	</button> -->
	<input type="button" id="chat" value="私訊分享者" class="btn btn-primary" style="margin :5px 0;width:100%;height:45px ">
	

	</c:otherwise>
	</c:choose>
	</div>
<%--   功能按鈕      --%>

</div>
</div>

</div><!-- end of row basic info-->

</div><!-- end of basic_info -->

<div class="container" style="margin-top:30px">
<div class="row">
<div class="col-md-7">
<div class="share-clean">
<ul class="nav nav-tabs">
<li class="active"><a data-toggle="tab" href="#descrption">分享描述</a></li>
<li><a data-toggle="tab" href="#message">討論</a></li>
</ul>

	<div class="tab-content">
	<div id="descrption" class="tab-pane fade in active">
    	<ul style="padding-left:15px ; list-style-type:none;">
    	<li style="display: list-item;margin-bottom:15px; margin-top:25px">
    	<span class="glyphicon glyphicon-tag"></span>
    	<strong>說明:</strong>
    	<p style="padding-left:20px">${itembean.item_description}</p>
    	</li>
		</ul>
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
    	<p style="overflow-x: hidden;overflow-y:auto;">${message.message}</span>
    	</li>
    	</c:forEach>
    	<p id="endline"/>
    	</ul>
    	<textarea id="messageboard" class="form-control" style="margin:15px 0" placeholder="請輸入留言訊息"></textarea>
    	<div class="text-right">
    	<input id="sendmessage" class="btn btn-default" type="button" value="留言" style="width:100px" maxlength="30">
		</div>    
    </div>
  </div>
</div>
</div>
<div id="other-info" class="col-md-5">
<h3 class="text-center" style="margin:15px 0px 10px 0px">
<strong>分享者資訊</strong>
</h3>
<div class="share-clean" role="alert" style="height:170px">	
<a href="${root}member/profile.controller?id=${itembean.member_id.member_no}" class="alert-link">
<div>
<img alt="${follow.member_followed.nickname}" src="${root}profileImages/${itembean.member_id.photo}" class="img-rounded pull-left" width="120" height="120" style="margin-right:45px">
</div>
</a>
<div style="margin-top:10px">
<h4>${itembean.member_id.nickname}</h1>
<span class="glyphicon glyphicon-home"></span>Hometown<p>${itembean.member_id.country} : ${itembean.member_id.city}</p>
</div>
</div>
</div>
</div>
</div>
<div id="dialog"></div>
<div id="board"></div>
<c:import url="../footer.jsp"></c:import>
<script type="text/javascript">

// location.replace('http://localhost:8080/SHAREBAR/secure/login.jsp');

var socket = null;
var user_id = Number("${user.member_no}");
var user_name ="${user.nickname}";
var item_status = "未提出"
var getNextOffset = function() { return count*215; };
var count = 0;
var checklogin = "<%=request.getContextPath()%>/secure/login.jsp";

$(function(){
	//判斷是否追蹤	
	var itemid = ${itembean.item_id}
	var item_name = "${itembean.item_name}"
	var item_host = ${itembean.member_id.member_no}
	var item_hostName = "${itembean.member_id.nickname}"
	var itemstatus = 0;
	
	$.get("<%=request.getContextPath()%>/followitems/itemStatus.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}"},
			function(data){
		itemstatus = data;
		if(itemstatus==1){
			$("#followtext").attr("value","取消追蹤")
			$("#followshow").toggleClass("btn-change");
		}
	})
	
	//追隨按鈕
	$('#followtext').click(function(){
		if(user_id == ""){
			location.assign(checklogin);
		}
		var change = $(this);
		var itemid = change.attr("value");
	$.post("followItem.do",{"MemberID":"${user.member_no}","ItemID":"${itembean.item_id}"},
			
			function(data){
					change.attr("following",data);
					if(data==1){
						$("#followtext").attr("value","取消追蹤")
						$("#followshow").toggleClass("btn-change");
					}
					else{
						$("#followtext").attr("value","追蹤按鈕")
						 $("#followshow").toggleClass("btn-change");
					}
				})
	})
	//切換圖片功能
	var showpic =null;
	$(".item_pic").click(function(){
		if(!$("#showpic").is(":animated")){
			showpic=$(this).attr("src");
			var chackorder = $("#showpic").attr("order");
			var thisorder = $(this).attr("order")
			showpic2=$("#showpic").attr("src");
			$("#showpic2").attr("src",showpic2);
			$("#showpic").attr("src",showpic);
			var order =  $(this).attr("order");
			$("#showpic").attr("order",order)
			if(chackorder > thisorder){
				$("#showpic2").hide("slide", { direction: "right" }, "300" ,function(){
				$("#showpic2").show();					
				});
				$("#showpic").effect("slide",{direction:"left"},300);
			}
			if(chackorder < thisorder){
				$("#showpic2").hide("slide", { direction: "left" }, "300",function(){
				$("#showpic2").show();					
				} );
				$("#showpic").effect("slide",{direction:"right"},300);
			}
			$("#showpic2").show();
// 			$("#showpic").effect( "slide", "200" );
		
		}
	})
	
	//切換圖片prev-btn next-btn
	var thisorder =null;
	$("#picgroup>span").click(function(){
		var maxpic=$("#piccount").attr("maxpic")
		var thisid = $(this).attr("id");
		thisorder = $("#showpic").attr("order");
		var ordint = parseInt(thisorder) 
		if(!$("#showpic").is(":animated")){
			var ordercount = ordint;
			if("next-btn" == thisid){
				ordercount = ordint + 1
			}
			if("prev-btn" == thisid){
				ordercount = ordint - 1
			}
			if(ordercount>maxpic){
				ordercount = 1;
			}
			if(ordercount<1){
				ordercount = maxpic;
			}	
			showpic = $('img[order='+ ordercount +']').attr("src")
			$("#showpic").attr("order",ordercount)
			showpic2=$("#showpic").attr("src");
			$("#showpic2").attr("src",showpic2);
			$("#showpic").attr("src",showpic)
			if("next-btn" == thisid){
				$("#showpic2").hide("slide", { direction: "left" }, "300",function(){
					$("#showpic2").show();					
					} );
					$("#showpic").effect("slide",{direction:"right"},300);
			}
			if("prev-btn" == thisid){
				$("#showpic2").hide("slide", { direction: "right" }, "300" ,function(){
					$("#showpic2").show();					
					});
					$("#showpic").effect("slide",{direction:"left"},300);
			}
		}
	})
	
	//留言版websocket
	var webSocket = null;
	function initwebsocket(){
		webSocket = new WebSocket('wss://${pageContext.request.getServerName()}:${pageContext.request.getServerPort()}${pageContext.request.contextPath}/item/MessageBoardWebSocket');
	
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
// 		alert("websocket close")
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
	    	'<p style="overflow-x: hidden;overflow-y:auto">'+message+'</span>'+
	    	'</li>'
			)
	$('.newmessage').show(400);		
	}
	function onError(evt){
	}
	
	//留言版功能
	$('#sendmessage').click(function(){
// 		alert("click");
		if(user_id == ""){
			location.assign(checklogin);
		}
	var message = $("#messageboard").val();
	var photo ="${user.photo}";
	var nickname = "${user.nickname}";
	var itemid = ${itembean.item_id};
	var member_no = user_id;
	
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
	
	//聊天系統
	//初始化步驟
	startConnection();
	messageWindow();

	$.get("../chatAction.ajax", { "action":"check", "item":itemid, "requester":user_id }, 
			function(data){											
		if( data != "未提出" ){
			item_status = data;
			switch (item_status){
			case "已送出":				
				$("#ask").toggleClass("btn-default");
				$("#ask").attr("value","請求已送出");
				$("#ask").attr("id","done")
				break;
			case "已拒絕":
				$("#ask").toggleClass("btn-danger");
				$("#ask").attr("value","已拒絕");
				$("#ask").attr("id","done")
				break;
			case "已成交":
				break;
			}
		}						
		});
	
	$('#chat').click(function() {
		if(user_id == ""){
			location.assign(checklogin);
		}
		var item_id = itemid;
		var requester_id = user_id;
		var host_id = item_host;
		var windowcode = item_id + "_" + host_id + "_" + requester_id;		
		$("#" + windowcode).chatbox("option", "boxManager").toggleBox();
	})
	//點擊聊天視窗，設為已讀
	$("body").on("click",".ui-chatbox",function(){			
		var item_id = $(this).find(".ui-chatbox-log").attr("id").split("_")[0];
		var host_id = $(this).find(".ui-chatbox-log").attr("id").split("_")[1];
		var requester_id = $(this).find(".ui-chatbox-log").attr("id").split("_")[2];
		var speaker_id = (user_id==host_id?requester_id : host_id);
		//呼叫servlet
		$.post("../mailReaded.ajax",{item : item_id, speaker : speaker_id, listener : user_id});
		})
	//鼠標停留聊天視窗
	$("body").on("focus",".ui-chatbox-input",function(){
		$(this).siblings(".ui-chatbox-log").attr("data-readed","1");
		})
	//鼠標離開聊天視窗
	$("body").on("blur",".ui-chatbox-input",function(){
		$(this).siblings(".ui-chatbox-log").attr("data-readed","0");
		})	
	$('#ask').click(function() {
		if($(this).attr("id") == "done"){return};
		var thisBtn  = $(this);	
		if(user_id == ""){
			location.assign(checklogin);
		}
		BootstrapDialog.show({
			title:item_name,
			message: "即將對此分享提出請求，是否繼續？",
			buttons: [{
		        label: '取消',
		        cssClass:'btn',
		        action: function(dialogRef) {
		        	dialogRef.close();
		               }},
		        {
		        label: '確認',
		        cssClass:'btn btn-warning',
		        action: function(dialogRef) {
		        	startAction(thisBtn);
		        	dialogRef.close();
		        }}]
			})
	})
	
	function startConnection(){
	    var url = 'wss://${pageContext.request.getServerName()}:${pageContext.request.getServerPort()}${pageContext.request.contextPath}/websocket/'+user_id;
	    socket = new WebSocket(url);	
	    socket.onmessage = function(event) {
	        addMessage(event.data);
	    };
	}
			
	function startAction(thisBtn) {					
		thisBtn.attr("value","處理中");				
		var action_str = thisBtn.attr("id");
				
		$.get("../chatAction.ajax", { "action":action_str, "item":itemid, "requester":user_id }, 
				function(data){											
					setTimeout(function() {
						$("#ask").toggleClass("btn-default");
						$("#ask").attr("value","請求已送出");
						$("#ask").attr("id","done");
						var msg = "對你的分享進行了請求。";
						var windowcode = itemid + "_" + item_host + "_" + user_id; 
						socket.send(JSON.stringify({content : msg, item : itemid, requester : user_id, title : item_name, speaker : user_id, listener : item_host, user : user_name, windowcode : windowcode}));
						$.post("../messageInsert.ajax",{content : msg, item : itemid, speaker : user_id, listener : item_host});			
					}, 1000)						
			});
		}

	function messageWindow() {
		var item_id = itemid;
		var title_str = item_name ;
		var host_id = item_host;
		var requester_id = user_id;
		var windowcode = item_id + "_" + host_id + "_" + requester_id;
		
		var window = $("<div></div>").attr("id", windowcode).attr("data-readed",0);
		var listener_id = (user_id==host_id?requester_id : host_id);
		$("#board").append(window);
		
		$("#" + windowcode).chatbox({				
			id : user_id, 
            user : user_name,
            title : '( ' + item_hostName + ' ) ' + title_str,
            width : 200,
            offset : getNextOffset(),
            hidden: true,
            messageSent : function(id, user, msg) {                      		
            	if(socket.readyState != 1){startConnection();}
                socket.send(JSON.stringify({content : msg, item : item_id, requester : requester_id, title : title_str, speaker : user_id, listener : listener_id, user : user, windowcode : windowcode}));
                $.post("../messageInsert.ajax",{content : msg, item : item_id, speaker : user_id, listener : listener_id});
                }});

    	count++;	

		$.getJSON("../pullMessage.ajax", {	"item":item_id, "requester":requester_id}, 
				function(data){
					$.each(data, function(index, bean){
					$("#" + windowcode).chatbox("option", "boxManager").addMsg(bean.memberBean_speaker.nickname, bean.context);
					});
				})
		
		$("#" + windowcode).chatbox("option", "hidden", true);		
			} 
			
         
    function addMessage(message) {
    	message = JSON.parse(message);
		var windowcode = message.windowcode;        
		$("#" + windowcode).chatbox("option", "hidden", false);
       	$("#" + windowcode).chatbox("option", "boxManager").addMsg(message.user, message.content);
      	//若正在關注此視窗設為已讀
   		if( $("#" + windowcode).attr("data-readed") == 0 ){
			$.post("../mailReaded.ajax",{item : message.item, speaker : message.speaker, listener : message.listener});
    		}
        } 
    
    //檢舉按鈕
	$('div #report').click(function() {
		if(user_id == ""){
			location.assign(checklogin);
		}
        BootstrapDialog.show({
	        title: '檢舉這個物品',
            message:       	 
				$('<div>請描述檢舉原因:</div>  <input type="text" class="form-control">'),		                       		 
            buttons: [{
                label: '確認',
                action: function(dialogRef) {
                	$('.modal-dialog b').remove();                  
					var rateMessage = dialogRef.getModalBody().find(':text').val();
					var error = $("<b>請填寫原因&nbsp;&nbsp;&nbsp;</b>");
					error.css("display","none");
					if (  rateMessage.length == 0 ){
						$('.modal-dialog .btn').before(error);
						$('.modal-dialog b').fadeIn();							
						}
					else {
						reportItem(user_id,itemid,rateMessage);					
						dialogRef.close();
						}
                }
            }]
        });
		})
		
	function reportItem(user_id,itemid,rateMessage){
		var reporting_member_id = user_id				
		var reported_item_id = itemid;
		var context = rateMessage;
		$.get("../administrator/ReportInsertServlet",{"reporting_member_id":reporting_member_id,"reported_item_id":reported_item_id,"context":context});			
	
	}	
    
    
});
</script>
</body>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>
</html>