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
<link type="text/css" rel="stylesheet" href="js/bootstrap-dialog/bootstrap-dialog.css" />

<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery-chatbox/jquery-1.12.4.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script type="text/javascript" src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery-chatbox/jquery.ui.chatbox.js"></script>
<script type="text/javascript" src="js/jquery-chatbox/chatboxManager.js"></script>
<script type="text/javascript" src="js/bootstrap-dialog/bootstrap-dialog.js"></script>

</head>
<body>
	<div id="header"></div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="classblock">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#share_mail">分享的訊息總覽</a></li>
						<li><a data-toggle="tab" href="#request_mail">請求的訊息總覽</a></li>
						<li><a data-toggle="tab" href="#service_mail">我的信箱</a></li>
						<li><a data-toggle="tab" href="#write_mail">寫信給客服人員</a></li>
					</ul>
					<div class="tab-content">
						
						
						<div id="share_mail" class="tab-pane fade in active">
							<div>&nbsp;</div>
							<c:if test="${not empty share_mail}">
								<table align="center" class="col-md-8 table table-hover">
									<thead>
										<tr>
											<th></th>
											<th>狀態</th>
											<th>互動</th>
											<th>分享物</th>
											<th>請求人</th>
											<th>最後回覆時間</th>
											<th>評價</th>											
										</tr>
									</thead>
									<tbody id="shareBody">
										<c:forEach var="share_mail" items="${share_mail}">
											<tr id="${share_mail[0]}&${share_mail[2]}">																						
												<td id="read"></td>
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
													<input id="acept" type="button" value="成交" 	class="btn btn-warning" 
													data-action="acept"
													data-title="${share_mail[1]}"
													data-item="${share_mail[0]}"						
													data-requester="${share_mail[2]}"
													data-requester_name="${share_mail[3]}">												
													<input id="refuse" type="button" value="拒絕" class="btn btn-warning" 
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
												<td><input id="chat" type="button" value="聊天" class="btn btn-info"
													data-item="${share_mail[0]}"
													data-title='${share_mail[1]}'
													data-host="${user.member_no}"
													data-requester="${share_mail[2]}"></td>													
												<td>${share_mail[1]}</td>
												<td>${share_mail[3]}</td>
												<td>${share_mail[4]}</td>
												<td>											
												<c:if test="${ share_mail[7] != share_mail[2] && share_mail[8] eq 0 }">
													<input id="rate" type="button" value="評價" class="btn btn-success"
															data-item="${share_mail[0]}" 
															data-awarder="${share_mail[3]}" 
															data-host="${user.member_no}"
															style="visibility:hidden;">	
												</c:if>	
												<c:if test="${ share_mail[7] == share_mail[2] && share_mail[8] eq 0 }">
													<input id="rate" type="button" value="評價" class="btn btn-success"
															data-item="${share_mail[0]}" 
															data-awarder="${share_mail[3]}" 
															data-host="${user.member_no}">	
												</c:if>												
												<c:if test="${ share_mail[7] == share_mail[2] && share_mail[8] ne 0 }">
														已評價
												</c:if>
												</td>											
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
						<div id="request_mail" class="tab-pane fade">
							<div>&nbsp;</div>
							<c:if test="${not empty request_mail}">
								<table align="center" class="col-md-8 table table-hover">
									<thead>
										<tr>
											<th></th>
											<th>狀態</th>
											<th>互動</th>
											<th>分享物</th>
											<th>請求人</th>
											<th>最後回覆時間</th>
											<th>評價</th>												
										</tr>
									</thead>
									<tbody id="requestBody">
										<c:forEach var="request_mail" items="${request_mail}">
											<tr id="${request_mail[0]}&${user.member_no}">												
												<td id="read"></td>
												<td id="status">
													<c:if test="${ request_mail[6] == 1 && request_mail[7] == user.member_no}">
														已成交
													</c:if>
													<c:if test="${ request_mail[6] == 1 && request_mail[7] != user.member_no}">
														已被鎖定
													</c:if>
													<c:if test="${ request_mail[6] == 0 && empty request_mail[5] }">																						
													<input id="ask" type="button" value="提出請求" class="btn btn-warning"
													style="display:inline" 
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
												<td><input id="chat" type="button" value="聊天" class="btn btn-info"												
													data-item="${request_mail[0]}"
													data-title='${request_mail[1]}'
													data-host="${request_mail[2]}"
													data-requester="${user.member_no}"
													></td>
												<td>${request_mail[1]}</td>
												<td>${request_mail[3]}</td>
												<td>${request_mail[4]}</td>
												<td>											
												<c:if test="${ request_mail[7] != user.member_no && request_mail[9] eq 0 }">
													<input id="rate" type="button" value="評價" class="btn btn-success"
															data-item="${request_mail[0]}" 
															data-awarder="${request_mail[3]}" 
															data-host="${request_mail[2]}"
															style="visibility:hidden;">
													<div id="image" style="display:none;">
													&nbsp;&nbsp;&nbsp;<img src="img/loading_s.gif">
													</div>
												</c:if>
												<c:if test="${ request_mail[7] == user.member_no && request_mail[9] eq 0 }">
													<input id="rate" type="button" value="評價" class="btn btn-success"
															data-item="${request_mail[0]}" 
															data-awarder="${request_mail[3]}" 
															data-host="${request_mail[2]}">
													<div id="image" style="display:none;">
													&nbsp;&nbsp;&nbsp;<img src="img/loading_s.gif">
													</div>	
												</c:if>												
												<c:if test="${ request_mail[7] == user.member_no && request_mail[9] ne 0 }">
														已評價
												</c:if>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
						
						<div id="service_mail" class="tab-pane fade">
												
							
							<table align="center" class="col-md-8 col-md-offset-2">	
										<tr align="center">
											<td class="st1">&nbsp;信件編號&nbsp;</td>
<!-- 											<td class="st1">&nbsp;會員ID&nbsp;</td>			 -->
											<td class="st1">&nbsp;發信時間&nbsp;</td>			
											<td class="st1">&nbsp;信件內容&nbsp;</td>
											<td class="st1">&nbsp;回覆時間&nbsp;</td>
											<td class="st1">&nbsp;客服回覆&nbsp;</td>
										</tr>
									<c:forEach var="element4" items="${service_mail}">
										<c:url value="gm_view05_1.jsp" var="path">
											<c:param name="mail_id" value="${element4.mail_id}" />
<%-- 											<c:param name="member_id" value="${element4.member_id}" /> --%>
											<c:param name="time" value="${element4.time}" />
											<c:param name="context" value="${element4.context}" />
											<c:param name="reply_time" value="${element4.reply_time}" />
											<c:param name="gm_reply_context" value="${element4.gm_reply_context}" />				
										</c:url>
						
										<tr>
											<td align="center"  class="st1">${element4.mail_id}</td>
<%-- 											<td align="center"  class="st1">${element4.member_id}</td> --%>
											<td class="st1">&nbsp; ${element4.time} &nbsp;</td>
											<td class="st1">${element4.context}</td>
											<td class="st1">&nbsp; ${element4.reply_time} &nbsp;</td>
											<td class="st1">${element4.gm_reply_context}</td>													
										</tr>
									</c:forEach>		
							</table>						
						</div>
						
						<div id="write_mail" class="tab-pane fade">							
								<div><textarea style="width:500px;height:200px;" id="mailcontext">請輸入信件內容...</textarea></div>
								<div><input  type="button" id="send" value="發送郵件"></div>	
						</div>
																		
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="board"></div>
	<div id="footer"></div>
</body>
<script>
var socket = null;
var user_id = Number("${user.member_no}");
var user_name = "${user.nickname}";
var getNextOffset = function() { return count*215; };
var count = 0;



	$(function() {		
		$("#header").load("header.jsp");
		$("#footer").load("footer.jsp");
		startConnection();
		
		
		//阿典新增
		$('body #send').click(function(){
				alert("信件已寄出");				
			var member_id = user_id;
			var context = $("#mailcontext").val();
// 				alert(member_id);
// 				alert(context);
			$.get("administrator/MailInsertServlet",{"member_id":member_id,"context":context}
			);			
		})
		
		
		//點擊聊天按鈕，跳出聊天室窗
		$('tbody #chat').click(function() {
			var item_id = $(this).data("item");
			var title_id = $(this).data("title");
			var host_id = $(this).data("host");
			var requester_id = $(this).data("requester");
			var windowcode = item_id + "_" + host_id + "_" + requester_id;
			
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
		
		//點擊提出請求、成交、拒絕按鈕
		$('tbody #ask,#acept,#refuse').click(function() {
			var thisBtn = $(this);
			var title_str = thisBtn.data("title");
			var name_str = thisBtn.data("requester_name");
			
			BootstrapDialog.show({
				title:title_str,
				message: function(dialogRef){
					var actionVal = $('<div></div>');
					if (thisBtn.data("action") == "ask")
						actionVal.text("即將對此分享提出請求，是否繼續？");
					if (thisBtn.data("action") == "acept")
						actionVal.text("即將同意 " + name_str + " 的請求，是否繼續？");
					if (thisBtn.data("action") == "refuse")
						actionVal.text("即將拒絕 " + name_str + " 的請求，是否繼續？");
					return actionVal;
					},
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
		
		//評價按鈕
		$('tbody #rate').click(function() {
			var thisBtn = $(this);
			var name_str = thisBtn.data("awarder"); 
	        BootstrapDialog.show({
		        title: '對 ' + name_str + ' 的評價',
	            message:       	 
					$('<label class="radio-inline"><input type="radio" name="optradio" value="3" >滿意</label><label class="radio-inline"><input type="radio" name="optradio" value="2" >不錯</label><label class="radio-inline"><input type="radio" name="optradio" value="1" >失望</label><div>&nbsp;</div><div>留下評語:</div><input type="text" class="form-control" style="background-color:#fffdcc">'),		                       		 
	            buttons: [{
	                label: '確認',
	                cssClass: 'btn btn-warning',
	                action: function(dialogRef) {
	                	$('.modal-dialog b').remove();
	                    var rateScore = dialogRef.getModalBody().find(':checked[name="optradio"]').val();
						var rateMessage = dialogRef.getModalBody().find(':text').val();
						var error = $("<b style='color:#ff5255'>請給予評價並留下評語&nbsp;&nbsp;&nbsp;</b>");
						error.css("display","none");
						if ( rateScore === undefined || rateMessage.length == 0 ){
							$('.modal-dialog .btn').before(error);
							$('.modal-dialog b').fadeIn();							
							}
						else {
							startRate( thisBtn, rateScore, rateMessage );
							dialogRef.close();
							}
	                }
	            }]
	        });
			})
		
		//點擊聊天視窗，設為已讀
		$("body").on("click",".ui-chatbox",function(){			
			var item_id = $(this).find(".ui-chatbox-log").attr("id").split("_")[0];
			var host_id = $(this).find(".ui-chatbox-log").attr("id").split("_")[1];
			var requester_id = $(this).find(".ui-chatbox-log").attr("id").split("_")[2];
			var speaker_id = (user_id==host_id?requester_id : host_id);
			//呼叫servlet
			$.post("mailReaded.ajax",{item : item_id, speaker : speaker_id, listener : user_id});

			})
		//鼠標停留聊天視窗
		$("body").on("focus",".ui-chatbox-input",function(){
			$(this).siblings(".ui-chatbox-log").attr("data-readed","1");
			})
		//鼠標離開聊天視窗
		$("body").on("blur",".ui-chatbox-input",function(){
			$(this).siblings(".ui-chatbox-log").attr("data-readed","0");
			})
		
		function startAction(thisBtn) {		
			thisBtn.css("display","none");
			thisBtn.siblings("input").css("display","none");
			thisBtn.siblings("div").css("display","inline");			
			var action_str = thisBtn.data("action");
			var item_id = thisBtn.data("item");
			var requester_id = thisBtn.data("requester");
			if ( action_str == "acept"){
				setTimeout(function() {
					thisBtn.parent().parent().find("#rate").css("visibility","visible");
				}, 1500)
				}
								
			$.get("chatAction.ajax", { "action":action_str, "item":item_id, "requester":requester_id }, 
					function( data ){											
						setTimeout(function() {
							thisBtn.parent().text(data);
							thisBtn.siblings("div").css("display","none");
						}, 1000)						
				});
			}

		function startRate( thisBtn, rateScore, rateMessage ){
			thisBtn.css("display","none");
			thisBtn.siblings("div").css("display","inline");
			var item_id = thisBtn.data("item");
			var host_id = thisBtn.data("host");
			if ( host_id == user_id )
				$.post("rateInsert.ajax", { "item":item_id, "target":"getter", "rateScore":rateScore, "rateMessage":rateMessage }, 
						function(data){											
							setTimeout(function() {							
								thisBtn.siblings("div").css("display","none");
								thisBtn.parent().text("已評價");
							}, 1000)						
					});
			else
				$.post("rateInsert.ajax", { "item":item_id, "target":"giver", "rateScore":rateScore, "rateMessage":rateMessage }, 
						function(data){											
							setTimeout(function() {							
								thisBtn.siblings("div").css("display","none");
								thisBtn.parent().text("已評價");
							}, 1000)						
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
			var window = $("<div></div>").attr("id", windowcode).attr("data-readed",1);
			//傳送訊息用
			var listener_id = (user_id==host_id?requester_id : host_id);
			//設為已讀用
			var speaker_id = (user_id==host_id?requester_id : host_id);
			
			$("#board").append(window);
			
			$("#" + windowcode).chatbox({				
				id : user_id, 
                user : user_name,
                title : '( ' + listener_id + ' ) ' + title_id,
                width : 200,
                offset : getNextOffset(),
                messageSent : function(id, user, msg) {                      		
                	if(socket.readyState != 1){startConnection();}
                    socket.send(JSON.stringify({content : msg, item : item_id, requester : requester_id, title : title_id, speaker : user_id, listener : listener_id, user : user, windowcode : windowcode}));
                    $.post("messageInsert.ajax",{content : msg, item : item_id, speaker : user_id, listener : listener_id});
                }});
            count++;
			//設為已讀
            $.post("mailReaded.ajax",{item : item_id, speaker : speaker_id, listener : user_id});			
				} 		
			})
             
        function addMessage(message) {
    		message = JSON.parse(message);
			var windowcode = message.windowcode;
			var trcode = message.item + "tr" + message.requester;

            if ($("#" + windowcode).length){
				$("#" + windowcode).chatbox("option", "hidden", false);
           		$("#" + windowcode).chatbox("option", "boxManager").addMsg(message.user, message.content);
           		$("#" + trcode).child().text("new");
            }
			else {
				var window = $("<div></div>").attr("id", windowcode).attr("data-readed",0);
				var listener_id = (user_id==message.speaker?message.listener : message.speaker);
				$("#board").append(window);			
				$("#" + windowcode).chatbox({				
					id : user_id, 
                	user : user_name,
                	title : '( ' + listener_id + ' ) ' + message.title,
                	width : 200,
               		offset : getNextOffset(),
                	messageSent : function(id, user, msg) {          
                		if(socket.readyState != 1){startConnection();}
                		//傳送socket
                    	socket.send(JSON.stringify({content : msg, item : message.item, requester : message.requester, title : message.title, speaker : user_id, listener : listener_id, user : user, windowcode : windowcode}));
                    	//寫入資料庫
                    	$.post("messageInsert.ajax",{content : msg, item : message.item, speaker : user_id, listener : listener_id});
            			}});				            	
				//讀取歷史訊息
            	$.getJSON("pullMessage.ajax", {	"item":message.item, "requester":message.requester}, 
        			function(data){
        			$.each(data, function(index, bean){
        				$("#" + windowcode).chatbox("option", "boxManager").addMsg(bean.memberBean_speaker.nickname, bean.context);
        				});
            		$("#" + windowcode).chatbox("option", "boxManager").addMsg(message.user, message.content);            		
        			})
        		       		
        		count++;      						
            }     				
          	//若正在關注此視窗設為已讀
       		if( $("#" + windowcode).attr("data-readed") == 0 ){
    			$.post("mailReaded.ajax",{item : message.item, speaker : message.speaker, listener : message.listener});
    			$("#" + trcode).child().text("");
        		}
       		//新增及移動訊息<tr>位置
    		if( message.requester == user_id && $("#" + trcode).length )
    			$("#" + trcode).child().text("new");
    			$('#requestBody').append($("#" + trcode));
        	if( message.requester != user_id && $("#" + trcode).length )		
        		$('#shareBody').append($("#" + trcode));
       		if( message.requester != user_id && !$("#" + trcode).length ){
        		var newBox = $('<tr><td id="read">new</td><td id="read"></td></tr>')
        		$('#shareBody').append(newBox);
            	}
        		           
        }
	

	
	
</script>
</html>