<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="../js/jquery-chatbox/jquery.ui.chatbox.css" />

<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-chatbox/jquery-1.12.4.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script type="text/javascript" src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery-chatbox/jquery.ui.chatbox.js"></script>
<script type="text/javascript" src="../js/jquery-chatbox/chatboxManager.js"></script>

<title>Profile Page</title>
<script type="text/javascript">

socket = null;
user_id = Number("${user.member_no}");
user_name = "${user.nickname}";
getNextOffset = function() { return count*215; };
count = 0;

$(function(){
	$("#header").load("../header.jsp");
	$("#footer").load("../footer.jsp");
	//判斷是否追蹤	
	var itemid = ${itembean.item_id}
	var item_name = "${itembean.item_name}"
	var item_host = ${itembean.member_id.member_no}
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
	$("div>input:eq(1)").click(function(){
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
		showpic=$(this).attr("src");
		showpic2=$("#showpic").attr("src");
		$("#showpic2").attr("src",showpic2);
		$("#showpic").attr("src",showpic);
		$("#showpic").effect( "slide", "200" );
	})

	//聊天系統
	//初始化步驟
	startConnection();
	messageWindow();
	
	$('#chat').click(function() {
		var item_id = itemid;
		var requester_id = user_id;
		var windowcode = item_id + "and" + requester_id;		
		$("#" + windowcode).chatbox("option", "boxManager").toggleBox();
	})
	
	$('#ask').click(function() {
		var thisBtn  = $(this);	
		$("#dialog").text("即將對此分享提出請求，是否繼續？");		
		$("#dialog").dialog({
			modal:true,
			resizable: false,
			title: item_name,
			closeText: "hide",
			open: function(){
				$(".ui-widget-overlay").bind("click", function(event,ui){
					$("#dialog").dialog("close");
					})
				},				
			buttons:{
				"取消": function(){
					$(this).dialog("close");
					$("#dialog").text("");						
					},
				"確認": function(){
					$(this).dialog("close");
					$("#dialog").text("");
					startAction(thisBtn);						
					}
				}
		})
		$(".ui-dialog-titlebar-close").hide();
	})
	
	function startConnection(){
	    var url = 'ws://${pageContext.request.getServerName()}:${pageContext.request.getServerPort()}${pageContext.request.contextPath}/websocket/'+user_id;
	    socket = new WebSocket(url);	
	    socket.onmessage = function(event) {
	        addMessage(event.data);
	    };
	}
			
	function startAction(thisBtn) {		
		thisBtn.css("display","none");			
		var action_str = thisBtn.attr("id");
		
		$.get("chatAction.ajax", { "action":action_str, "item":itemid, "requester":user_id }, 
				function(data){											
					setTimeout(function() {
						$("#dialog").text("已提出請求。");		
						$("#dialog").dialog({
							modal:true,
							resizable: false,
							title: item_name,
							closeText: "hide",
							open: function(){
								$(".ui-widget-overlay").bind("click", function(event,ui){
									$("#dialog").dialog("close");
									})
								},				
							buttons:{								
								"確認": function(){
									$(this).dialog("close");
									$("#dialog").text("");						
									}
								}
						})
						$(".ui-dialog-titlebar-close").hide();
					}, 500)						
			});
		}

	function messageWindow() {
		var item_id = itemid;
		var title_id = '( ' + user_name + ' ) ' + item_name ;
		var host_id = item_host;
		var requester_id = user_id;
		var windowcode = item_id + "and" + requester_id;
		
		var window = $("<div></div>").attr("id", windowcode);
		var listener_id = (user_id==host_id?requester_id : host_id);
		$("#board").append(window);
		
		$("#" + windowcode).chatbox({				
			id : user_id, 
            user : user_name,
            title : title_id,
            width : 200,
            offset : getNextOffset(),
            hidden: true,
            messageSent : function(id, user, msg) {                      		
            	if(socket.readyState != 1){startConnection();}
                socket.send(JSON.stringify({content : msg, item : item_id, requester : requester_id, title : title_id, speaker : user_id, listener : listener_id, user : user, windowcode : windowcode}));
            }});

    	count++;	

		$.getJSON("../pullMessage.ajax", {	"item":item_id, "requester":requester_id}, 
				function(data){
					$.each(data, function(index, bean){
					$("#" + windowcode).chatbox("option", "boxManager").addMsg(bean.memberBean_speaker.member_nickname, bean.context);
					});
				})
		
		$("#" + windowcode).chatbox("option", "hidden", true);		
			} 
			
         
    function addMessage(message) {
    	message = JSON.parse(message);
		var windowcode = message.windowcode;        
		$("#" + windowcode).chatbox("option", "hidden", false);
       	$("#" + windowcode).chatbox("option", "boxManager").addMsg(message.user, message.content);
        } 
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


/* .item_pic{ */
/* 	cursor: pointer; */
/* } */


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
	<div class="row">
	<div class="col-md-9" >
	<c:forEach var="image" items="${itembean.imageBean}" varStatus="stat">
		<c:if test="${stat.first}">
				<img class="show_pic" id="showpic" alt="item_image" src="${root}item-image/${image.image_photo}" style="z-index:2;position:absolute">
		</c:if>
	</c:forEach>
	<img class="show_pic" id="showpic2" alt="item_image" src="" style="z-index:1;top:0;left:15px;">
	</div>
	<%--   功能按鈕      --%>

	<div class="col-md-3">
	<div >
	<c:choose>
	<c:when test="${itembean.member_id.member_no eq user.member_no}">
	<input type="button" value="Edit" class="btn btn-primary">
	</c:when>
	<c:otherwise>
	<input type="button" id="chat" value="私訊分享者" class="btn btn-primary" style="margin :15px">
	<input type="button" value="追蹤按鈕" class="btn btn-default" style="width:80px;margin :15px" >
	<input type="button" value="檢舉商品" class="btn btn-default" style="margin :15px">
<%-- 		<c:if test=${ itembean.done == 0 }> --%>
			<input type="button" id="ask" value="提出分享請求" class="btn btn-default" style="margin :15px">
<%-- 		</c:if> --%>
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
    	
    	<c:forEach var="message" items="${itembean.messageboard}" varStatus="stat">
    	<div class="text-center">
    	<p>${message.member_id }</p>
    	<span>${message.message}</span>
    	</div>
    	<c:if test="${stat.last}"><hr/></c:if>
    	</c:forEach>
    	<form action="" method="post">
    	<textarea class="form-control" style="margin:15px 0" placeholder="請輸入留言訊息"></textarea>
    	<input class="pull-right btn btn-default" type="button" value="留言" style="width:100px">
    	<span class="ui-icon ui-icon-arrowthick-1-n"></span>
    	 </form>
    	
    	
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
<div id="dialog"></div>
<div id="board"></div>
<div id="header"></div>
</body>
</html>
