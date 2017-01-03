<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Header</title>

<!-- 注意！注意！注意！ -->
<!-- 引用header時需要import以下六個plugin，置於根目錄的js資料夾內 -->

<!-- <link rel="stylesheet" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="js/jquery-ui-1.12.1.custom/jquery-ui.css"/> -->
<!-- <script src="js/jquery-3.1.1.min.js"></script> -->
<!-- <script src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script> -->
<!-- <script src="js/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script> -->
<!-- <script src="js/jquery.validate.min.js"></script> -->

<!-- 以下id請勿再使用 -->
<!-- navbar, id_form, id_select, id_search, id_submit, latlng -->

<!-- 以下name請勿再使用 -->
<!-- searchSelector, searchBar -->

<style>
div#navbar {
	width: 100%;
	text-align: center;
	height:10%;
}

.class_li {
	margin-left: 5px;
	margin-right: 5px;
}
</style>
</head>
<c:url value="/" var="root"></c:url>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
					    <span class="icon-bar"></span>
       					<span class="icon-bar"></span>
       					<span class="icon-bar"></span>  
				</button>
				<a class="navbar-brand" href="<c:url value='/index.jsp'/>">SHARE BAR!</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
			<form id="id_form" class="navbar-form navbar-left" action="<c:url value="/item/search.controller" />" method="get" style="margin-right: 5px">
				<select id="id_select" name="searchSelector">
					<option value="location">地區</option>
					<option value="itemName">物品</option>
				</select>
				<div class="form-group">
					<input type="text" id="id_search" name="searchBar" class="form-control" placeholder="Search" style="width: 300px" /></td>
				</div>
				<button type="submit" id="id_submit" class="btn btn-default">Submit</button>
				<table id="latlng"></table>
			</form>
			<ul class="nav navbar-nav navbar-right" style="margin-right: 5px">
				<c:choose>
					<c:when test="${empty user eq true}">
						<li class="class_li"><a href="<c:url value='/secure/signup.jsp'/>"><span class="glyphicon glyphicon-plus"></span>Sign Up</a></li>
						<li class="class_li"><a href="<c:url value='/secure/login.jsp'/>"><span class="glyphicon glyphicon-log-out"></span>Login</a></li>
					</c:when>
					<c:otherwise>
						<li class="class_li"><a href="<c:url value='/member/userProfile.jsp'/>"><span class="glyphicon glyphicon-user"></span>${user.nickname}<img class="img-circle" alt="user_photo" src="${root}profileImages/${user.photo}" width="24" height="24"></a></li>
						<li class="class_li"><a href="<c:url value='/member/inbox.jsp'/>"><span class="glyphicon glyphicon-envelope"></span>Mail</a></li>
						<li class="class_li" style="border-right: 1px solid #E6E6E6"><a href="<c:url value='/secure/logout.jsp'/>"><span class="glyphicon glyphicon-log-in"></span>Logout</a></li>
						<li class="class_li"><a href="<c:url value='/item/InsertItem.jsp'/>"><span class="glyphicon glyphicon-gift"></span>Share</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
			</div>
		</div>
	</nav>
	
	<script>
		var geocoder;
		var googleAutocomplete;
		var input;
	    var availableTags = [
	        "ActionScript",
	        "AppleScript",
	        "Asp",
	        "BASIC",
	        "C",
	        "C++",
	        "Clojure",
	        "COBOL",
	        "ColdFusion",
	        "Erlang",
	        "Fortran",
	        "Groovy",
	        "Haskell",
	        "Java",
	        "JavaScript",
	        "Lisp",
	        "Perl",
	        "PHP",
	        "Python",
	        "Ruby",
	        "Scala",
	        "Scheme"
	    ];
	    
	    $(document).ready(function(){
	    	// 物品自動完成
// 	    	$("#id_search").on("autocompletechange", function(){
// 				var searchBar = $("#id_search").val();
// 				$.getJSON("searchBar.ajax", {"itemName": searchBar}, function(data){
// 					$.each(data, function(index, item){
// 						availableTags = [];
// 						availableTags.push(item.item_name);	
// 						alert(item.item_name);
// 					});
// 					alert(availableTags)
// 				});
// 			});
	    	
	    	// 表單驗證
			$('#id_form').validate({
				event: "blur",
				rules: {
					searchBar: "required",
				},
				messages: {
					searchBar: "",
				},
			});
	    });
	    
	    // 初始化
		function initMap() {
		    // 地區自動完成
		    var defaultBounds = new google.maps.LatLngBounds(
		    			new google.maps.LatLng(26, 124),
		    			new google.maps.LatLng(23, 120)
		    		);
		    var options = {
// 		    			bounds: defaultBounds,
// 		    			types: ['establishment']
// 		    			types: ['address']
						types: ['geocode']
		    		};
		    input = document.getElementById('id_search');
// 			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
			googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			geocoder = new google.maps.Geocoder();
		}

		// 切換自動完成
		$("#id_select").on("change", function() {
// 			alert($("#id_select").val());
			if($("#id_select").find(":selected").val() === "itemName") {
				$("#id_search").autocomplete({source: availableTags});
				google.maps.event.clearInstanceListeners(input);
				$('#id_search').autocomplete('enable');
			} else {
				$('#id_search').autocomplete('disable');
				var options = {
// 		    			types: ['establishment']
						types: ['geocode']
// 		    			types: ['address']
		    		};
				googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			}
		});
		
		// 更改搜尋條件
		$("#id_search").on("change", function(event){
// 			event.preventDefault();
			var searchSelector = $("#id_select").find(":selected").val();
// 			alert(searchSelector);
			var searchBar = $("#id_search").val();
// 			alert(searchBar);
			
			// 找地區
			if(searchSelector == "location"){
				geocoder.geocode({ 'address': searchBar }, function(results, status) {
			        if (status == google.maps.GeocoderStatus.OK) {
// 			        	var lat = results[0].geometry.location.lat();
// 						var lng = results[0].geometry.location.lng();
// 						alert(lat + ", " + lng);
// 						alert(results[0].geometry.viewport);
// 						var bounds = results[0].geometry.viewport;
// 			            var inputLat = $("<input name='latitude' style='display:none'>").val(lat);
// 						var inputLng = $("<input name='longitude' style='display:none'>").val(lng);
// 						var inputBounds = $("<input name='bounds' style='display:none'>").val(bounds);
// 						var tdLatLng = $("<td style='display:none'></td>").append([inputLat, inputLng, inputBounds]);
// 						var trLatLnf = $("<tr style='display:none'></tr>").append(tdLatLng)
// 						$("#latlng").append(trLatLnf);
			        } else if (searchBar == "") {
// 			        	alert("searchBar = null");
// 			        	if (navigator.geolocation) {
// 							navigator.geolocation.getCurrentPosition(success, error);
// 			        	}
// 			        	function success(position) {
// 			        		var lat = position.coords.latitude;
// 			        		var lng = position.coords.longitude;
// 			     			alert(lat + ", " + lng);
// 			     			var currentLatLng = { lat: position.coords.latitude, lng: position.coords.longitude }
// 			    			geocoder.geocode({ 'location': currentLatLng }, function(results, status) {
// 			    				if (status == google.maps.GeocoderStatus.OK) {
// 			    					var inputLat = $("<input name='latitude' style='display:none'>").val(lat);
// 									var inputLng = $("<input name='longitude' style='display:none'>").val(lng);
// 									var tdLatLng = $("<td style='display:none'></td>").append([inputLat, inputLng]);
// 									var trLatLnf = $("<tr style='display:none'></tr>").append(tdLatLng)
// 									$("#latlng").append(trLatLnf);
// 			    				}
// 			    			})
// 			    		}
			        } else {
			            alert("請輸入詳細地址");
			        }
			    });
			}
			
			// 找物品
			if(searchSelector == "itemName"){
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(success, error);
	        	}
	        	function success(position) {
	        		var lat = position.coords.latitude;
	        		var lng = position.coords.longitude;
	     			alert(lat + ", " + lng);
	     			var currentLatLng = { lat: position.coords.latitude, lng: position.coords.longitude }
	    			geocoder.geocode({ 'location': currentLatLng }, function(results, status) {
	    				if (status == google.maps.GeocoderStatus.OK) {
	    					var bounds = results[0].geometry.viewport;
// 	    					alert(bounds);
	    					var inputLat = $("<input name='latitude' style='display:none'>").val(lat);
							var inputLng = $("<input name='longitude' style='display:none'>").val(lng);
							var inputBounds = $("<input name='bounds' style='display:none'>").val(bounds);
							var tdLatLng = $("<td style='display:none'></td>").append([inputLat, inputLng, inputBounds]);
							var trLatLnf = $("<tr style='display:none'></tr>").append(tdLatLng)
							$("#latlng").append(trLatLnf);
	    				}
	    			});
	    		}
			}
		});
		
		function error(error) {
			switch(error.code) {
				case 0: alert(error.message); break;
				case 1: alert("使用者拒絕使用"); break;
				case 2: alert("瀏覽器無法處理"); break;
				case 3: alert("瀏覽器時間到了無法取得位置"); break;
				default: alert("who knows"); break;
			}
		}
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJznZ1ht-uJFa-tBJBpYYtzQ2609ba2Eg&libraries=places&callback=initMap&language=zh-TW"></script>
</body>
</html>