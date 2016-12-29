<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改分享物資訊</title>
<link rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="../js/jquery.uploadPreview.min.js"></script>
<script src="../js/jquery.validate.min.js"></script>
<style>
html, body {
	width: 100%;
	min-width: 100%;
	height: 100%;
	min-height: 100%;
	margin: 0;
	padding: 0;
}

.wrapper {
	width: 100%;
}

.container {
	width: 500px;
	float: left;
}

#id_update_form {
	width: 1000px;
	height: auto;
	margin: 0 auto;
	margin-top: 50px;
}

#id_image_form {
	margin-top: 20px;
}

#id_item_description {
	height: 100px;
}

.error {
	background-color: #FFD2D2;
}

.image-preview {
	width: 200px;
	height: 200px;
	position: relative;
	overflow: hidden;
	background-color: #ffffff;
	color: #ecf0f1;
	float: left;
	margin: 10px;
	border: silver 1px solid;
}

.image-preview input {
	line-height: 200px;
	font-size: 200px;
	position: absolute;
	opacity: 0;
	z-index: 10;
}

.image-preview label {
	position: absolute;
	z-index: 5;
	opacity: 0.8;
	cursor: pointer;
	background-color: #bdc3c7;
	width: 200px;
	height: 50px;
	font-size: 20px;
	line-height: 50px;
	text-transform: uppercase;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	margin: auto;
	text-align: center;
}
</style>
</head>
<body>
	<%@ page import="org.springframework.web.context.WebApplicationContext"%>
	<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
	<%@ page import="category.model.*"%>
	<%@ page import="category.model.dao.*"%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

		ClassService classService = (ClassService) context.getBean("classService");
		ClassBean selectAll = new ClassBean();
		List<ClassBean> beanList = classService.select(null);
		pageContext.setAttribute("classBeanList", beanList);
		List<String> stringList = new ArrayList<String>();
		for (ClassBean bean : beanList) {
// 			out.println(bean);
// 			out.println(bean.getClass_name());
			stringList.add(bean.getClass_name());
		}
		request.setAttribute("classNameList", stringList);
	%>
<%-- 	<p>${classNameList}</p> --%>
	<div id="header"></div>
	<div class="wrapper">
		<form id="id_update_form" action="<c:url value="/item/update.controller" />" method="post" enctype="multipart/form-data">
			<div>
				<div id="id_image_form" class="container">
					<div id="id_image_div1" class="form-group image-preview">
						<label for="id_image_photo1" id="id_image_label1">封面照片</label>
						<input type="file" id="id_image_photo1" name="image_photo1">
						<input type="text" name="image_id1" value="${param.image_id1}" style='display:none'>
					</div>
					<div id="id_image_div2" class="form-group image-preview">
						<label for="id_image_photo2" id="id_image_label2">選擇照片</label>
						<input type="file" id="id_image_photo2" name="image_photo2">
						<input type="text" name="image_id2" value="${param.image_id2}" style='display:none'>
					</div>
					<div id="id_image_div3" class="form-group image-preview">
						<label for="id_image_photo3" id="id_image_label3">選擇照片</label>
						<input type="file" id="id_image_photo3" name="image_photo3">
						<input type="text" name="image_id3" value="${param.image_id3}" style='display:none'>
					</div>
					<div id="id_image_div4" class="form-group image-preview">
						<label for="id_image_photo4" id="id_image_label4">選擇照片</label>
						<input type="file" id="id_image_photo4" name="image_photo4">
						<input type="text" name="image_id4" value="${param.image_id4}" style='display:none'>
					</div>
				</div>
				<div id="id_item_form" class="container">
					<legend>修改分享物資訊</legend>
					<div style='display:none'>
						<input type="text" name="item_id" value="${param.item_id}">
					</div>
					<div class="form-group">
						<label for="id_item_name">名稱</label>
						<input type="text" id="id_item_name" name="item_name" class="form-control" value="${param.item_name}">
					</div>
					<div class="form-group">
						<label for="id_class_name">分類</label>
						<select id="id_class_name" name="class_name" class="form-control">
							<option></option>
							<c:forEach var="class_name" items="${classNameList}">
								<option>${class_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="id_location">地點</label>
						<input type="text" id="id_location" name="location" class="form-control" placeholder="地區，地址" value="${param.location}">
					</div>
					<div class="form-group">
						<label for="id_end_date">結束日期</label>
						<input type="text" id="id_end_date" name="end_date" class="form-control" readonly="readonly" placeholder="刊登至..." value="${param.end_date}">
					</div>
					<div class="form-group">
						<label for="id_item_description">描述</label>
						<textarea id="id_item_description" name="item_description" class="form-control" placeholder="50字以內">${param.item_description}</textarea>
					</div>
					<div class="form-group">
						<input type="submit" id="id_submit" class="btn btn-default" value="修改">
						<span id="span_error"></span>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<script>
		var geocoder;
		var lat;
		var lng;
		var input;
		
		// 初始化
		function initMap() {
			// 地址自動完成
		    var defaultBounds = new google.maps.LatLngBounds(
		    			new google.maps.LatLng(26, 124),
		    			new google.maps.LatLng(23, 120)
		    		);
		    var options = {types: ['geocode']};
		    input = document.getElementById('id_location');
			googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			
			// 取得經緯度物件
		    geocoder = new google.maps.Geocoder();
		}
		
		$(function() {
			$("#header").load("../header.jsp");
			
			// 日期選擇器
			$("#id_end_date").datepicker({
				dateFormat: 'yy-mm-dd',
				minDate : "+1d",
				maxDate : "+1y"
			});
			
			// 照片預覽
			$.uploadPreview({
				input_field: "#id_image_photo1",	// Default: .image-upload
				preview_box: "#id_image_div1",		// Default: .image-preview
				label_field: "#id_image_label1",	// Default: .image-label
				label_default: "選擇照片",			// Default: Choose File
				label_selected: "更換照片",			// Default: Change File
				no_label: false						// Default: false
			});
			$.uploadPreview({
				input_field: "#id_image_photo2",
				preview_box: "#id_image_div2",
				label_field: "#id_image_label2",
				label_default: "選擇照片",
				label_selected: "更換照片",
				no_label: false
			});
				$.uploadPreview({
				input_field: "#id_image_photo3",
				preview_box: "#id_image_div3",
				label_field: "#id_image_label3",
				label_default: "選擇照片",
				label_selected: "更換照片",
				no_label: false
			});
			$.uploadPreview({
				input_field: "#id_image_photo4",
				preview_box: "#id_image_div4",
				label_field: "#id_image_label4",
				label_default: "選擇照片",
				label_selected: "更換照片",
				no_label: false
			});
			
			// 表單驗證
			$('#id_update_form').validate({
				event: "blur",
				rules: {
                	item_name: "required",
                	class_name: "required",
                	location: "required",
//                 	image_photo1: "required",
                	image_photo1: {
                		required: true,
                		accept: "jpg, png, jpeg, gif",
                	},
				},
				messages: {
					image_photo1: "請上傳封面照片",
				},
				highlight: function (element) {
		            $(element).addClass('error');
// 		            $("#id_image_label1").addClass('error');
		            $("#id_image_div1").css("background-color", "#FFD2D2");
		        },
		        unhighlight: function (element) {
		            $(element).removeClass('error');
// 		            $("#id_image_label1").removeClass('error');
		            $("#id_image_div1").css("background-color", "#ffffff");
		        },
				errorPlacement: function(error, element) {
					if(element.is("#id_image_photo1")){
						error.appendTo(element.siblings("span"));						
					}
				},
				submitHandler: function(){
					$(this).submit();
				},
			});
		});
		
		// 取得經緯度
		$("#id_location").on("change", function(event){
// 			event.preventDefault();
			var id_location = $("#id_location").val();
			alert(id_location);
			geocoder.geocode({ 'address': id_location }, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					lat = results[0].geometry.location.lat();
					lng = results[0].geometry.location.lng();
					alert(lat + " ," + lng);
					var inputLat = $("<input name='latitude' style='display:none'>").val(lat);
					var inputLng = $("<input name='longitude' style='display:none'>").val(lng);
					var divLatLng = $("<div style='display:none'></div>").append([inputLat, inputLng]);
// 					var divLatLnf = $("<div style='display:none'></div>").append(tdLatLng)
					$("#id_item_form").append(divLatLng);
				} else {
					alert("請輸入詳細地址");
				}
			});
		});
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJznZ1ht-uJFa-tBJBpYYtzQ2609ba2Eg&libraries=places&callback=initMap&language=zh-TW"></script>
</body>
</html>