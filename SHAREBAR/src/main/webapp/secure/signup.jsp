<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root"></c:url>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script
  src="https://code.jquery.com/jquery-2.2.4.min.js"
  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
  crossorigin="anonymous"></script>
<script src="../js/cropit-master/jquery.cropit.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-signin-client_id"
	content="307771007729-rmscbeafik1eh81eo2v9rtv4bb5n1tml.apps.googleusercontent.com">
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel=stylesheet type="text/css" href="../css/share.css">
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<script src="../js/bootstrap-validator.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script><!-- GSignIn -->
<script>window.history.forward();</script>
<title>SignUp</title>
<style type="text/css">
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
.error {
	color: #F00;
	font-weight: bold;
}
#message{
	color: #F00;
	font-weight: bold;
}
div#sign_up_div{
	margin:auto auto;
	width:300px;
}
form#sign_up{ 
	margin: 100px auto; 
	width:250px;
}
a#fbsign{
	margin: 100px auto; 
	width:250px;
}
img#imgPreview{
	width: 100px;
	height: 100px;
}
#g-signin2{
	width:100%;
}
.with-errors{
	font-family: Arial, Helvetica, sans-serif;
	color:red;
}


/* for cropit */
      .cropit-preview {
        background-color: #f8f8f8;
        background-size: cover;
        border: 1px solid #ccc;
        border-radius: 3px;
        margin-top: 7px;
        width: 250px;
        height: 250px;
      }

      .cropit-preview-image-container {
        cursor: move;
      }

      .image-size-label {
        margin-top: 10px;
      }
</style>
</head>
<%
String from = request.getHeader("Referer");
if(from != null){
	String temp = from.substring(from.lastIndexOf("SHAREBAR/") + 9);
	if(temp.equals("secure/login.jsp") || temp.equals("secure/signup.jsp")){
	
	}else{
		session.setAttribute("from",from);	
	}
}else{
	session.setAttribute("from", pageContext.getAttribute("root"));
}
%>
<body>
<jsp:include page="../header.jsp"></jsp:include>
	<div id="sign_up_div" class="row">
		<form id="sign_up" data-toggle="validator" action="signup.controller" method="POST" enctype="multipart/form-data">
			<div class="form-group">
			<div id="g-signin2" class="g-signin2" data-onsuccess="onSignIn" data-width="240" data-height="50" data-longtitle="true">
			</div>
			<div id="Gerror" class="form-group">
			</div>
			<legend>Personal info: </legend>
			<div class="form-group">
			<label for="first_name">First name:</label><input type="text" class="form-control" id="first_name" name="first_name" value="${param.first_name}" required>
			</div>
			<div class="form-group">
			<label for="last_name">Last name:</label><input type="text" class="form-control" id="last_name" name="last_name" value="${param.last_name}" required>
			</div>
			<div class="form-group">
			<label for="country">Country:</label><input type="text" class="form-control" id="country" name="country" value="${param.country}" required>
			</div>
			<div class="form-group">
			<label for="city">City:</label><input type="text" class="form-control" id="city" name="city" value="${param.city}" required>
			</div>
			<legend>Sign Up:</legend>
			<div class="form-group">
			<label for="member_email">Account name(email):</label>
			<div class="input-group">
			<input type="email" class="form-control" id="member_email" name="member_email" placeholder="Email" value="${param.member_email}" data-error="Bruh, that email address is invalid" required/>
			<div class="input-group-addon"><span id="act_check" class="glyphicon glyphicon-question-sign"></span></div>
			</div>
			<div class="help-block with-errors">${errors.id}</div>
			</div>
			<div class="form-group">
			<label for="password">Password:</label><input type="password" class="form-control" id="password" name="password" data-minlength="8" placeholder="Password" data-error="Minimum of 8 characters"required>
			<div class="help-block with-errors">${errors.password}</div>
			</div>
			<div class="form-group">
			<label for="confirm_password">confirm_password:</label> <input type="password" class="form-control" id="confirm_password" name="confirm_password" data-match="#password" data-error="woops, doen't match password" required>
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="member_nickname">Presented name:</label></label><input type="text" class="form-control" id="member_nickname" name="member_nickname" value="${param.member_nickname}" data-error="This is what other user would see" required>
			<div class="help-block with-errors">${errors.nickname}</div>
			</div>
			<div class="form-group">
			<label for="member_description">Description:</label><textarea type="text" class="form-control" id="member_description" name="member_description" maxlength="50" data-error="Please introduce yourself" required>${param.member_description}</textarea>
			<div class="help-block with-errors">${errors.description}</div>
			</div>
			
			
			<div class="form-group">
			<div class="image-editor">
			<label for="member_photo">Image:</label>
			<input type="file" class="form-control-file cropit-image-input" id="member_photo" name="member_photo" accept="image/*" data-error="Please input a png file" required><br>
			<div class="cropit-preview"></div>
        	<div class="image-size-label">
          	Resize image
       		</div>
       		<input type="range" class="cropit-image-zoom-input"/>
        	<input type="hidden" name="image-data" class="hidden-image-data" />
        	</div>
			<div class="help-block with-errors">${errors.photo}</div>
			</div>
			
			
			<div class="form-group">
			<button id="submitbtn" type="submit" class="btn btn-primary">Send</button> <button type="reset" class="btn btn-primary">Reset</button>
			</div>
			<div id="message">${errors.system}</div>
			<div id="ajaxCheck" style="color:red"></div>
		</form>
	</div>
	
	<!-- login dialog -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Alert!</h4>
      </div>
      <div class="modal-body">
        You are already login.<br>
        Do you want to logout first?
      </div>
      <div class="modal-footer">
        <button id="ModalNo" type="button" class="btn btn-default" >No</button>
        <button id="ModalLogout" type="button" class="btn btn-primary">Logout</button>
      </div>
    </div>
  </div>
</div>
<!-- login dialog -->
	
	<script>
	var from = "${from}";
	if(from!=="undefined"){from = from.substring(from.lastIndexOf("SHAREBAR/")+9)}
	
		
	$(function(){
		$('.image-editor').cropit();
		
		$("#submitbtn").click(function(event){
			var stat = $("#act_check").attr("account");
			var imageData = $('.image-editor').cropit('export');
	        $('.hidden-image-data').val(imageData);
			if(stat=="exist"){
				event.preventDefault();
				$("#ajaxCheck").html("<p style='font-weight:bold'>This account is already exist, please change your email.</p>")
			}
		});//end of click
		

//         $('form').submit(function() {
//           // Move cropped image data to hidden input
//           var imageData = $('.image-editor').cropit('export');
//           $('.hidden-image-data').val(imageData);
//           $('.cropit-image-zoom-input').prop('disable', true);
// //           $('.cropit-image-input').prop('disabled', true);

//           // Print HTTP request params
// //           var formValue = $(this).serialize();
// //           $('#result-data').text(formValue);
//         });
		//check account
		$("#member_email").change(function(){
			var emailID = $("#member_email").val();
			var validmail = validateEmail(emailID);
			var image = $("#act_check");
			if(validmail){
				$.get("AccountCheck",{"account":emailID},function(data){
					console.log("data="+data);
					if(data == "exist"){
						image
						.removeClass("glyphicon-question-sign")
						.removeClass("glyphicon-ok-sign")
						.addClass("glyphicon-remove-sign");
						image.attr("account","exist");
					}else if(data == "none"){
						image
						.removeClass("glyphicon-question-sign")
						.removeClass("glyphicon-remove-sign")
						.addClass("glyphicon-ok-sign");
						image.attr("account","none")
					}else{
						image
						.removeClass("glyphicon-remove-sign")
						.removeClass("glyphicon-ok-sign")
						.addClass("glyphicon-question-sign");
					}
				})//end of $.get
			}else{
				image
				.removeClass("glyphicon-remove-sign")
				.removeClass("glyphicon-ok-sign")
				.addClass("glyphicon-question-sign");
			}
		});//end of focusout
		
		
		
		//切換圖片用================================
	    function readURL(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	            
	            reader.onload = function (e) {
	                $('#imgPreview').attr('src', e.target.result);
	            }            
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
	    $("#member_photo").change(function(){
	        readURL(this);
	    });
	    //========================================
	    		    
	});//end of ready
	
    function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		var id_token = googleUser.getAuthResponse().id_token;
		
		console.log('profile: ' + profile);
		console.log('id_token: ' + id_token);
		console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		console.log('Name: ' + profile.getName());
		console.log('Given Name: ' + profile.getGivenName());
		console.log('Family Name: ' + profile.getFamilyName());
		console.log('Image URL: ' + profile.getImageUrl());
		console.log('Email: ' + profile.getEmail());
		console.log('===========================================');

		
		$.post("tokensignin",{"id_token":id_token,"ID":profile.getId(),"Name":profile.getName(),"Given Name":profile.getGivenName(),"Family Name":profile.getFamilyName(),"Image URL":profile.getImageUrl(),"Email":profile.getEmail()},function(responseText){
			if(responseText == "GLoginSuccess"){
// 				console.log(responseText);
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				if(from!="secure/login.jsp" && from!="secure/signup.jsp" && typeof from !== "undefined"){window.location = "${from}";}
				else{window.location="${root}"}	
			}else if(responseText == "AccountExist"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				$("#Gerror").empty();
				$("#Gerror").append( "<p style='color:red'>connecting error please try other method.</p>" );
			}else if(responseText == "GSignAndLoginSuccess"){
// 				console.log(responseText);
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				if(from!="secure/login.jsp" && from!="secure/signup.jsp" && typeof from !== "undefined"){window.location = "${from}";}
				else{window.location="${root}"}	
			}else if(responseText == "InvalidIdToken"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
// 				console.log(responseText);
				$("#Gerror").empty();
				$("#Gerror").append( "<p style='color:red'>connecting error please try other method.</p>" );
			}else if(responseText == "GLoginfail"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
// 				console.log(responseText);
				$("#Gerror").empty();
				$("#Gerror").append( "<p style='color:red'>the account with this email is already exist</p>" );
			}else if(responseText == "alreadyLogin"){
				gapi.auth2.getAuthInstance().signOut().then(function() {
					console.log('User signed out.');
				});
				$('#myModal').modal('show');
// 				if(from!="secure/login.jsp" && from!="secure/signup.jsp" && typeof from !== "undefined"){window.location = "${from}";}
// 				else{window.location="${root}"}	
			}
		});
	}
	
    function validateEmail(email) {
    	  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    	  return re.test(email);
    	}
    
    $("#ModalLogout").click(function(){
    	window.location="${root}secure/logout.jsp";
    });
    $("#ModalNo").click(function(){
    	if(from!="secure/login.jsp" && from!="secure/signup.jsp" && typeof from !== "undefined"){window.location = "${from}";}
    	else{window.location="${root}"}
    });
	</script>
</body>
</html>