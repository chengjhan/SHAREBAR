<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SHARE BAR</title>
<link rel="shortcut icon" href="<c:url value='/favicon.ico'/>" type="image/x-icon" />
<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script
  src="https://code.jquery.com/jquery-2.2.4.min.js"
  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
  crossorigin="anonymous"></script>
<script src="../js/cropit-master/jquery.cropit.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="../js/bootstrap-validator.js"></script>
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
<body>
<c:url value="/" var="root"></c:url>
<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
	<div id="sign_up_div" class="row">
	<div class="col-md-3">
		<div class="list-group">
			<a href="changeInfo.jsp" class="list-group-item">CHANGE PROFILE</a>
			<a href="changePassword.jsp" class="list-group-item">CHANGE PASSWORD</a>
			<a href="changeProfilePhoto.jsp" class="list-group-item">CHANGE PHOTO</a>
		</div>
	</div>
	<div class="col-md-9">
		<form id="sign_up" data-toggle="validator" action="updateProfilePhoto.do" method="POST">
			<legend>Update info: </legend>
			
			
			<div class="form-group">
			<div class="image-editor">
			<label for="member_photo">Image:</label>
			<input type="file" class="form-control-file cropit-image-input" id="member_photo" name="member_photo" accept="image/x-png" data-error="Please input a png file" required><br>
			<div class="cropit-preview"></div>
        	<div class="image-size-label">
          	Resize image
       		</div>
       		<input type="range" class="cropit-image-zoom-input"/ style="width:30%">
        	<input type="hidden" name="image-data" class="hidden-image-data" />
        	</div>
			<div class="help-block with-errors">${errors.photo}</div>
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
	$(function() {
        $('.image-editor').cropit();

        $('form').submit(function() {
          // Move cropped image data to hidden input
          var imageData = $('.image-editor').cropit('export');
          $('.hidden-image-data').val(imageData);
          $('.cropit-image-zoom-input').prop('disable', true);
          $('.cropit-image-input').prop('disabled', true);

          return true;
        });
        
        $(".cropit-preview-image").attr("src",'<%=request.getContextPath()%>/profileImages/${user.photo}');
      });
	</script>
</body>
</html>