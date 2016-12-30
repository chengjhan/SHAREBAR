<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet" href="js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="js/jquery-chatbox/jquery.ui.chatbox.css" />

<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery-chatbox/jquery-1.12.4.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script type="text/javascript" src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery-chatbox/jquery.ui.chatbox.js"></script>
<script type="text/javascript" src="js/jquery-chatbox/chatboxManager.js"></script>

</head>
<body>
	<div id="header"></div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="classblock">
					<h3>會員編號：${user.member_no}</h3>
					<h3>會員信箱：${user.email}</h3>
					<h3>會員暱稱：${user.nickname}</h3>
					<h1>Here is mail_list.</h1>
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#share_mail">share_mail</a></li>
						<li><a data-toggle="tab" href="#request_mail">request_mail</a></li>
					</ul>
					<div class="tab-content">
						<div id="share_mail" class="tab-pane fade in active">
							<div>&nbsp;</div>
							<c:if test="${not empty share_mail}">
								<table align="center" class="col-md-8 col-md-offset-2">
									<thead>
										<tr>
											<th>status</th>
											<th>talk</th>
											<th>title</th>
											<th>resquester_id</th>
											<th>time</th>											
										</tr>
									</thead>
									<tbody>
										<c:forEach var="share_mail" items="${share_mail}">
											<tr>																						
												<td id="status">
												<c:if test="${ share_mail[6] == 1 && share_mail[7] == share_mail[2]}">
														已成交
												</c:if>
												<c:if test="${ share_mail[6] == 1 && share_mail[7] != share_mail[2]}">
														-鎖定-
												</c:if>
												<c:if test="${ share_mail[6] == 0 && empty share_mail[5] }">	
												</c:if>	
												<c:if test="${ share_mail[6] == 0 && share_mail[5] == '已送出' }">	
													<input id="acept" type="button" value="成交"
													style="color: black;" 
													data-action="acept"
													data-title="${share_mail[1]}"
													data-item="${share_mail[0]}"						
													data-requester="${share_mail[2]}"
													data-requester_name="${share_mail[3]}">												
													<input id="refuse" type="button" value="拒絕"
													style="color: black;" 
													data-action="refuse"
													data-title="${share_mail[1]}"
													data-item="${share_mail[0]}"						
													data-requester="${share_mail[2]}"
													data-requester_name="${share_mail[3]}">
													<div id="image" style="display:none;">
													&nbsp;&nbsp;&nbsp;<img src="img/loading_s.gif">
													</div>
												</c:if>
												<c:if test="${ share_mail[6] == 0 && share_mail[5] == '已拒絕' }">
														已拒絕
												</c:if>
												</td>												
												<td><input id="chat" type="button" value="聊天"
													style="color: black;" 
													data-item="${share_mail[0]}"
													data-title='( ${share_mail[3]} ) ${share_mail[1]}'
													data-host="${user.member_no}"
													data-requester="${share_mail[2]}"></td>													
												<td>${share_mail[1]}</td>
												<td>${share_mail[3]}</td>
												<td>${share_mail[4]}</td>											
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
						<div id="request_mail" class="tab-pane fade">
							<div>&nbsp;</div>
							<c:if test="${not empty request_mail}">
								<table align="center" class="col-md-8 col-md-offset-2">
									<thead>
										<tr>
											<th>status</th>
											<th>talk</th>										
											<th>title</th>
											<th>host_id</th>
											<th>time</th>											
										</tr>
									</thead>
									<tbody>
										<c:forEach var="request_mail" items="${request_mail}">
											<tr>												
												<td id="status">
													<c:if test="${ request_mail[6] == 1 && request_mail[7] == user.member_no}">
														已成交
													</c:if>
													<c:if test="${ request_mail[6] == 1 && request_mail[7] != user.member_no}">
														已被鎖定
													</c:if>
													<c:if test="${ request_mail[6] == 0 && empty request_mail[5] }">																						
													<input id="ask" type="button" value="提出請求"
													style="color: black; display:inline" 
													data-action="ask"
													data-title="${request_mail[1]}"
													data-item="${request_mail[0]}"						
													data-requester="${user.member_no}"
													data-requester_name="${user.nickname}">
													<div id="image" style="display:none;">
													&nbsp;&nbsp;&nbsp;<img src="img/loading_s.gif">
													</div>
													</c:if>
													<c:if test="${ request_mail[6] == 0 && request_mail[5] == '已送出' }">
														已送出
													</c:if>
													<c:if test="${ request_mail[6] == 0 && request_mail[5] == '已拒絕' }">
														已拒絕
													</c:if>
												</td>												
												<td><input id="chat" type="button" value="聊天"
													style="color: black;" 
													data-item="${request_mail[0]}"
													data-title='( ${request_mail[3]} ) ${request_mail[1]}'
													data-host="${request_mail[2]}"
													data-requester="${user.member_no}"
													></td>
												<td>${request_mail[1]}</td>
												<td>${request_mail[3]}</td>
												<td>${request_mail[4]}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dialog"></div>
	<div id="board"></div>
</body>
<script>
socket = null;
user_id = Number("${user.member_no}");
user_name = "${user.nickname}";
getNextOffset = function() { return count*215; };
count = 0;


	$(function() {		
		$("#header").load("header.jsp")
		
		startConnection();
		
		$('tbody #chat').click(function() {
			var item_id = $(this).data("item");
			var title_id = $(this).data("title");
			var host_id = $(this).data("host");
			var requester_id = $(this).data("requester");
			var windowcode = item_id + "and" + requester_id;
			
			if ($("#" + windowcode).length)
				$("#" + windowcode).chatbox("option", "boxManager").toggleBox();
			else{
				messageWindow(item_id, title_id, host_id, requester_id, windowcode);
				$.getJSON("pullMessage.ajax", {	"item":item_id, "requester":requester_id}, 
					function(data){
						$.each(data, function(index, bean){
						$("#" + windowcode).chatbox("option", "boxManager").addMsg(bean.memberBean_speaker.nickname, bean.context);
					});
				})
			;}
		})
		$('tbody #ask,#acept,#refuse').click(function() {
			var thisBtn = $(this);
			var title_str = thisBtn.data("title");
			var name_str = thisBtn.data("requester_name");
			if(thisBtn.data("action") == "ask")				
				$("#dialog").text("即將對此分享提出請求，是否繼續？");
			if(thisBtn.data("action") == "acept")				
				$("#dialog").text("即將同意 " + name_str + "的請求，是否繼續？");
			if(thisBtn.data("action") == "refuse")				
				$("#dialog").text("即將拒絕 " + name_str + "的請求，是否繼續？");
			
			$("#dialog").dialog({
				modal:true,
				resizable: false,
				title: title_str,
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
		
		
		
		function startAction(thisBtn) {		
			thisBtn.css("display","none");
			thisBtn.siblings("input").css("display","none");
			thisBtn.siblings("div").css("display","inline");			
			var action_str = thisBtn.data("action");
			var item_id = thisBtn.data("item");
			var requester_id = thisBtn.data("requester");
			
			$.get("chatAction.ajax", { "action":action_str, "item":item_id, "requester":requester_id }, 
					function(data){											
						setTimeout(function() {
							thisBtn.parent().text(data);
							thisBtn.siblings("div").css("display","none");
						}, 1500)						
				});
			}

        function startConnection(){
		    var url = 'ws://${pageContext.request.getServerName()}:${pageContext.request.getServerPort()}${pageContext.request.contextPath}/websocket/'+user_id;
		    socket = new WebSocket(url);	
		    socket.onmessage = function(event) {
		        addMessage(event.data);
		    };
		}
				
		function messageWindow(item_id, title_id, host_id, requester_id, windowcode) {
			var window = $("<div></div>").attr("id", windowcode);
			var listener_id = (user_id==host_id?requester_id : host_id);
			$("#board").append(window);
			
			$("#" + windowcode).chatbox({				
				id : user_id, 
                user : user_name,
                title : title_id,
                width : 200,
                offset : getNextOffset(),
                messageSent : function(id, user, msg) {                      		
                	if(socket.readyState != 1){startConnection();}
                    socket.send(JSON.stringify({content : msg, item : item_id, requester : requester_id, title : title_id, speaker : user_id, listener : listener_id, user : user, windowcode : windowcode}));
                }});
            	count++;			
				} 		
			})
             
        function addMessage(message) {
        	message = JSON.parse(message);
			var windowcode = message.windowcode;
            
            if ($("#" + windowcode).length){
				$("#" + windowcode).chatbox("option", "hidden", false);
           		$("#" + windowcode).chatbox("option", "boxManager").addMsg(message.user, message.content);
            }
			else {
				var window = $("<div></div>").attr("id", windowcode);
				var listener_id = (user_id==message.speaker?message.listener : message.speaker);
				$("#board").append(window);			
				$("#" + windowcode).chatbox({				
					id : user_id, 
                	user : user_name,
                	title : message.title,
                	width : 200,
               		offset : getNextOffset(),
                	messageSent : function(id, user, msg) {          
                		if(socket.readyState != 1){startConnection();}
                    	socket.send(JSON.stringify({content : msg, item : message.item, requester : message.requester, title : message.title, speaker : user_id, listener : listener_id, user : user, windowcode : windowcode}));
                			}});
            	
            	$.getJSON("pullMessage.ajax", {	"item":message.item, "requester":message.requester}, 
        			function(data){
        			$.each(data, function(index, bean){
        				$("#" + windowcode).chatbox("option", "boxManager").addMsg(bean.memberBean_speaker.nickname, bean.context);
        				});
            		$("#" + windowcode).chatbox("option", "boxManager").addMsg(message.user, message.content);
        			})
        		
        		count++;

            }     				
                         
        }
</script>
</html>