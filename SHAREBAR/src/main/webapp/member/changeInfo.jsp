<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="../js/bootstrap-validator.js"></script>
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
form{ 
	margin: 100px auto; 
	width:auto;
}
img#imgPreview{
	width: 100px;
	height: 100px;
}
div.list-group{
	margin: 100px auto; 
}
.container{
	margin:50px auto
}
.row>[class*='col-']{
 	display: table-cell;
	vertical-align:center;
	flex: 1; /* additionally, equal width */
	padding: 1em;
	horizontal-align:center;
}
</style>

</head>
<body>
<c:url value="/" var="root"></c:url>
<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
	<div id="sign_up_div" class="row">
	<div class="col-md-3">
		<div class="list-group">
			<a href="changeInfo.jsp" class="list-group-item">CHANGE PROFILE</a>
			<a href="changePassword.jsp" class="list-group-item">CHANGE PASSWORD</a>
		</div>
	</div>
	<div class="col-md-9">
		<form id="sign_up" data-toggle="validator" action="update.do" method="POST" enctype="multipart/form-data">
			<legend>Update info: </legend>
			<div class="form-group">
			<label for="first_name">First name:</label><input type="text" class="form-control" id="first_name" name="first_name" value="${user.first_name}" required>
			</div>
			<div class="form-group">
			<label for="last_name">Last name:</label><input type="text" class="form-control" id="last_name" name="last_name" value="${user.last_name}" required>
			</div>
			<div class="form-group">
			<label for="country">Country:</label><input type="text" class="form-control" id="country" name="country" value="${user.country}" required>
			</div>
			<div class="form-group">
			<label for="city">City:</label><input type="text" class="form-control" id="city" name="city" value="${user.city}" required>
			</div>
			<div class="form-group">
			<label for="member_nickname">Presented name:</label></label><input type="text" class="form-control" id="member_nickname" name="member_nickname" value="${user.nickname}" data-error="This is what other user would see" required>${errors.nickname}
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="member_description">Description:</label><textarea type="text" class="form-control" id="member_description" name="member_description" maxlength="50" data-error="Please introduce yourself" required>${user.description}</textarea>${errors.description}
			<div class="help-block with-errors"></div>
			</div>
			<div class="form-group">
			<label for="member_photo">Image:</label><input type="file" class="form-control-file" id="member_photo" name="member_photo" accept="image/x-png" data-error="Please input a png file" required>${errors.photo}<br><br><br>
			<img id="imgPreview"alt="your image" src="${root}profileImages/${user.photo}" >
			</div>
			<div class="form-group">
			<button type="submit" class="btn btn-primary">Store</button> <button type="reset" class="btn btn-primary">Reset</button>
			</div>
			<div id="message">${errors.system}</div>
		</form>
	</div>
	</div>
	</div>
	<script>
	$(function(){
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
	});//end of ready
	</script>
</body>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>

</html>