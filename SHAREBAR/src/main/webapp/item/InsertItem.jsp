<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>刊登分享物</title>
<link rel="shortcut icon" href="<c:url value='favicon.ico'/>" type="image/x-icon" />
<link rel=stylesheet type="text/css" href="../css/share.css">
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

.form-control {
	height: 40px
}

.form-group {
    margin-bottom: 30px;
}

#id_insert_form {
	width: 1000px;
	height: auto;
	margin: 0 auto;
	margin-top: 20px;
	margin-bottom: 50px;
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


#map-canvas {
	width: 565px;
	height: 480px;
	margin: 0;
	padding: 0;
}

#address {
	background-color: #fff;
	font-family: Roboto;
    font-size: 14px;
    font-weight: 400;
    margin-top: 10px;
	padding: 5px 11px 5px 13px;
    text-overflow: ellipsis;
    width: 430px;
    position:absolute;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
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
	
	<div class="container-fluid">
		<form id="id_insert_form" action="<c:url value="/item/share.controller" />" method="post" enctype="multipart/form-data">
			<div>
				<div id="id_image_form" class="container" style="width:500px;float:left;">
					<div id="id_image_div1" class="form-group image-preview">
						<label for="id_image_photo1" id="id_image_label1">封面照片</label>
						<input type="file" id="id_image_photo1" name="image_photo1">
					</div>
					<div id="id_image_div2" class="form-group image-preview">
						<label for="id_image_photo2" id="id_image_label2">選擇照片</label>
						<input type="file" id="id_image_photo2" name="image_photo2">
					</div>
					<div id="id_image_div3" class="form-group image-preview">
						<label for="id_image_photo3" id="id_image_label3">選擇照片</label>
						<input type="file" id="id_image_photo3" name="image_photo3">
					</div>
					<div id="id_image_div4" class="form-group image-preview">
						<label for="id_image_photo4" id="id_image_label4">選擇照片</label>
						<input type="file" id="id_image_photo4" name="image_photo4">
					</div>
				</div>

				<div id="id_item_form" class="container col-sm-6 col-md-6 share-clean">
					<legend>分享物品</legend>
					<div class="form-group">
						<label for="id_item_name">名稱</label>
						<input type="text" id="id_item_name" name="item_name" class="form-control">
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
					<label for="id_location">地點</label>
					<div class="form-group input-group">
						<div class="input-group-btn">
							<a class="btn btn-default" href="#myMapModal" data-toggle="modal" title="由地圖選取" style="height:40px">
	        					<i class="glyphicon glyphicon-search" style="padding-top:4px"></i>
	      					</a>
    						</div>
						<input type="text" id="id_location" name="location" class="form-control" placeholder="地區，地址">
						<span class="input-group-addon"><i id="id_location_ok" class="glyphicon glyphicon-remove"></i></span>
					</div>
					<div id="id_latlng" style='display:none'></div>
					<div class="form-group">
						<label for="id_end_date">結束日期</label>
						<input type="text" id="id_end_date" name="end_date" class="form-control" readonly="readonly" placeholder="刊登至...">
					</div>
					<div class="form-group">
						<label for="id_item_description">描述</label>
						<textarea id="id_item_description" name="item_description" class="form-control" placeholder="50字以內"></textarea>
					</div>
					<div class="form-group">
						<input type="submit" id="id_submit" class="btn btn-primary" value="刊登">
						<span id="span_error"></span>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<!-- 地圖modal -->
	<div class="modal fade" id="myMapModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<input type="text" id="address">
					<input type="text" id="lat" style="display:none">
					<input type="text" id="lon" style="display:none">
				</div>
				<div class="modal-body">
					<div class="container">
						<div class="row">
							<div id="map-canvas" class=""></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" id="id_modal_btn" class="btn btn-primary" data-dismiss="modal">確定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 成功訊息 -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog" style="width:300px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">分享物品</h4>
				</div>
				<div class="modal-body">
					<p>新增成功</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">確定</button>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script>
		var geocoder;
		var lat;
		var lng;
		var input;
		var map;
		var googleAutocomplete;
		var marker;
		var markerArray = [];
		var address;
		var strAddress;
		var clickLat;
		var clickLon;
		var inputLat;
		var inputLng;
		var divLatLng = $("#id_latlng");
		var headerInput;
		
		// 初始化
		function initMap() {
			
			// modal地圖
			map = new google.maps.Map(document.getElementById("map-canvas"), {
				center : { lat: 25.0329636, lng: 121.5654268 },
				zoom : 15,
				minZoom : 2
			});
			
			address = document.getElementById('address');
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(address);
			
			google.maps.event.addListener(map, "click", function(event) {
				deleteMarkers();

				clickLat = event.latLng.lat();
				clickLon = event.latLng.lng();
// 				alert(clickLat + "," + clickLon)

				document.getElementById("lat").value = clickLat.toFixed(6);
				document.getElementById("lon").value = clickLon.toFixed(6);

				marker = new google.maps.Marker({
					position : new google.maps.LatLng(clickLat, clickLon),
					draggable : true,
					map : map
				});
				markerArray.push(marker);
				
				var LatLng = { lat: clickLat, lng: clickLon };
				
				var geocoder = new google.maps.Geocoder();
				geocoder.geocode({ 'location': LatLng }, function(results, status) {
					if (status === google.maps.GeocoderStatus.OK) {
						if (results[0]) {
							strAddress = results[0].formatted_address;
							$("#address").val(results[0].formatted_address);
						} 
					}
				});
			});
			
			// 搜尋列地址自動完成
			headerInput = document.getElementById('id_search');
			googleAutocomplete = new google.maps.places.Autocomplete(headerInput, options);
			
			// 表單地址自動完成
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
			$('#id_insert_form').validate({
				event: "blur",
				rules: {
                	item_name: "required",
                	class_name: "required",
                	location: "required",
                	image_photo1: "required"
//                 	image_photo1: {
//                 		required: true,
//                 		accept: "jpg, png, jpeg, gif",
//                 	},
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
// 		            $("#id_image_div1").css("background-color", "#ffffff");
		        },
				errorPlacement: function(error, element) {
					if(element.is("#id_image_photo1")){
						error.appendTo(element.siblings("span"));						
					}
				},
				submitHandler: function(){
// 					$(this).submit();
				},
			});
		});
		
		// 輸入地址取得經緯度
		$("#id_location").on("change", getLatLng);
		$("#id_location").keypress(function (event) {
		    if (event.which === 13){
		    	getLatLng(event);
		    }
		});
		function getLatLng(event){
// 			event.preventDefault();
			var id_location = $("#id_location").val();
// 			alert(id_location);
			geocoder.geocode({ 'address': id_location }, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					lat = results[0].geometry.location.lat();
					lng = results[0].geometry.location.lng();
// 					alert(lat + " ," + lng);
					inputLat = $("<input name='latitude' style='display:none'>").val(lat);
					inputLng = $("<input name='longitude' style='display:none'>").val(lng);
					divLatLng.empty();
					divLatLng.append([inputLat, inputLng]);
// 					var divLatLnf = $("<div style='display:none'></div>").append(tdLatLng)
					$("#id_item_form").append(divLatLng);
					$("#id_location_ok").removeAttr("class").attr("class", "glyphicon glyphicon-ok");
				} else {
					alert("請輸入詳細地址");
					$("#id_location_ok").removeAttr("class").attr("class", "glyphicon glyphicon-remove")
				}
			});
		}
		
		// 點地圖取得經緯度
		$("#id_modal_btn").on("click", function(){
			$("#id_location").val(strAddress);
			inputLat = $("<input name='latitude' style='display:none'>").val(clickLat);
// 			alert(clickLat);
			inputLng = $("<input name='longitude' style='display:none'>").val(clickLon);
// 			alert(clickLon);
			divLatLng.empty();
			divLatLng.append([inputLat, inputLng]);
			$("#id_item_form").append(divLatLng);
			if(typeof(clickLat) == "number" && typeof(clickLon) == "number"){
				$("#id_location_ok").removeAttr("class").attr("class", "glyphicon glyphicon-ok");
			}
		});
		
		$('#myMapModal').on('show.bs.modal', function() {
			resizeMap();
		})

		function resizeMap() {
			if (typeof map == "undefined")
				return;
			setTimeout(function() {
				resizingMap();
			}, 400);
		}

		function resizingMap() {
			if (typeof map == "undefined")
				return;
			var center = map.getCenter();
			google.maps.event.trigger(map, "resize");
			map.setCenter(center);
		}
		
		function deleteMarkers() {
			clearMarkers();
			markerArray = [];
		}

		function clearMarkers() {
			setMapOnAll(null);
		}

		function setMapOnAll(map) {
			for (var i = 0; i < markerArray.length; i++) {
				markerArray[i].setMap(map);
			}
		}
		
		// 成功訊息
		$("#id_insert_form").on("submit", function(){
			var id_item_name = $("#id_item_name").val();
			var id_class_name = $("#id_class_name").val();
			var id_location = $("#id_location").val();
			var id_image_photo1 = $("#id_image_photo1").val();
			if(id_item_name != "" && id_class_name != "" && id_location != "" && id_image_photo1 != ""){
				$("#myModal").modal();
				$(this).submit();
			}
		})
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>
</body>
</html>