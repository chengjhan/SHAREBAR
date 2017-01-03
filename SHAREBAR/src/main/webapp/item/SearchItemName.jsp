<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>依物品搜尋</title>
<link rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<link rel="stylesheet" href="../js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="../js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="../js/jquery.validate.min.js"></script>
<style>
div#navbar {
	width: 100%;
	text-align: center;
}

.class_li {
	margin-left: 5px;
	margin-right: 5px;
}

html, body {
	width: 100%;
	min-width: 100%;
	height: 100%;
	min-height: 100%;
	margin: 0;
	padding: 0;
}

#wrapper {
	position: absolute;
	top: 52px;
	bottom: 0;
	left: 0;
	right: 0;
}

#left {
	height: 100%;
	width: 50%;
	position: absolute;
	left: 0px;
	float: left;
	overflow: scroll;
/* 	margin: 0px -15px; */
}

#map {
	height: auto;
	width: 50%;
	position: absolute;
	right: 0px;
	top: 0px;
	bottom: 0px;
}

.item_bean_div {
/* 	width: 45%; */
/* 	height: 400px; */
 	float: left;
/* 	margin: 0px;  */
	background-color: #FCFCFC;
 	margin-bottom: 15px;
}

.item_image_div {
	width: 100%;
}

.item_image_img {
	width: 100%;
}

.item_info_div {
	height: auto;
}

.item_text_div {
	margin: 12px;
}

.item_name_p {
	margin: 0px;
}

.item_location_p {
	margin: 0px;
}

#id_infoimage_div {
	width: 200px;
	height: 200px;
}

#id_infoimage_img {
	width: 100%;
	height: 100%;
}

#id_infotext_div {
	padding: 12px 5px 10px 5px;
}

.infotitle_a:link {
	color: black;
	text-decoration: none;
}

.infotitle_a:visited {
	color: black;
}

.infotitle_a:hover {
	color: black;
	text-decoration: underline;
}

.infotitle_a:active {
	color: black;
}

.infotext_a:link {
	color: black;
	text-decoration: none;
}

.infotext_a:visited {
	color: black;
}

.infotext_a:hover {
	color: black;
	text-decoration: none;
}

.infotext_a:active {
	color: black;
}
</style>
</head>
<body>
	<c:url value="/" var="root"></c:url>
	
<!-- header -->
	<div style="z-index:1000">
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
	</div>

<!-- body -->
	<div id="wrapper" class="container-fluid">
		<div class="row">
			<!--
			<div id="showBounds" style="color:red;"></div>
			<table id="itemList">
				<thead>
					<tr>
						<td>item_id</td>
						<td>item_name</td>
						<td>latitude</td>
						<td>longitude</td>
						<td>class_name</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="bean" items="${itemBean}">
						<c:url value="/pages/product.jsp" var="path">
							<c:param name="item_id" value="${bean.item_id}" />
							<c:param name="item_name" value="${bean.item_name}" />
							<c:param name="latitude" value="${bean.latitude}" />
							<c:param name="longitude" value="${bean.longitude}" />
						</c:url>
						<tr>
							<td>${bean.item_id}</td>
							<td>${bean.item_name}</td>
							<td>${bean.latitude}</td>
							<td>${bean.longitude}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			-->
			<div id="left" class="col-sm-6 col-md-6">
<!-- 				<div id="inner_left" class="row"></div> -->
			</div>
			<div id="map" class="col-sm-6 col-md-6"></div>
		</div>
	</div>
	
	<script>
	
		// 這裡開始是header
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
// 	    	物品自動完成
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
	    });
	    
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
// 			    		types: ['establishment']
						types: ['geocode']
//			    		types: ['address']
		    		};
				googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			}
		});
		
		// 更改搜尋條件
		$("#id_search").on("change", function(event){
//			event.preventDefault();
			var searchSelector = $("#id_select").find(":selected").val();
			alert(searchSelector);
			var searchBar = $("#id_search").val();
			alert(searchBar);
			
			// 找地區
			if(searchSelector == "location"){
				geocoder.geocode({ 'address': searchBar }, function(results, status) {
			        if (status == google.maps.GeocoderStatus.OK) {
			        	var lat = results[0].geometry.location.lat();
						var lng = results[0].geometry.location.lng();
						alert(lat + ", " + lng);
						alert(results[0].geometry.viewport);
						var bounds = results[0].geometry.viewport;
			            var inputLat = $("<input name='latitude' style='display:none'>").val(lat);
						var inputLng = $("<input name='longitude' style='display:none'>").val(lng);
						var inputBounds = $("<input name='bounds' style='display:none'>").val(bounds);
						var tdLatLng = $("<td style='display:none'></td>").append([inputLat, inputLng, inputBounds]);
						var trLatLnf = $("<tr style='display:none'></tr>").append(tdLatLng)
						$("#latlng").append(trLatLnf);
			        } else if (searchBar == "") {
			        	alert("searchBar = null");
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
			    					var inputLat = $("<input name='latitude' style='display:none'>").val(lat);
									var inputLng = $("<input name='longitude' style='display:none'>").val(lng);
									var tdLatLng = $("<td style='display:none'></td>").append([inputLat, inputLng]);
									var trLatLnf = $("<tr style='display:none'></tr>").append(tdLatLng)
									$("#latlng").append(trLatLnf);
			    				}
			    			})
			    		}
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
	    					alert(bounds);
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

		// 這裡開始是body
		var map;
		var itemArray = [];
		var markerArray = [];
		
		// 地圖初始化
		function initMap() {
			// header初始化
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
			googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			geocoder = new google.maps.Geocoder();
			
			// body初始化
			var centerLocation = {
				lat : 23.583234,
				lng : 120.5825975
				}
			map = new google.maps.Map(document.getElementById("map"), {
				center : centerLocation,
				zoom : 8
				});
			var swLat = ${swLat};
// 			alert(swLat);
			var swLng = ${swLng};
// 			alert(swLng);
			var swMarker = new google.maps.Marker({
   				position: {lat: swLat, lng: swLng},
//    			map: map
   			});
			var neLat = ${neLat};
// 			alert(neLat);
			var neLng = ${neLng};
// 			alert(neLng);
			var neMarker = new google.maps.Marker({
   				position: {lat: neLat, lng: neLng},
//    			map: map
   			});
			var bounds = new google.maps.LatLngBounds();
			bounds.extend(swMarker.position);
			bounds.extend(neMarker.position);
			map.fitBounds(bounds);
// 			var itemLatLng = { lat: ${bean.latitude}, lng: ${bean.longitude} };
// 			var marker = new google.maps.Marker({
//    			position: itemLatLng,
//    			map: map
//    		});
			
			// 由搜尋列第一次搜尋
			var table = $("#itemList>tbody");
			var photo = $("#left")
			var searchBar = "${searchBar}";
			$.getJSON("searchItemName.ajax", {
				"searchBar": searchBar,
				"swLat": swLat,
				"swLng": swLng,
				"neLat": neLat,
				"neLng": neLng
			}, function(data){
// 				table.empty();
				photo.empty();
				var count = 1;
				$.each(data, function(index, item){
					
					// 製作物品資訊陣列
					var aItem = [item.item_id, item.item_name, item.classBean.class_name, item.location, item.latitude, item.longitude, item.imageBean[0].image_photo ];
// 					alert(aItem);
					itemArray.push(aItem);
					
					// 製作物品資訊列表
// 					var cell1 = $("<td></td>").text(item.item_id);
// 					var cell2 = $("<td></td>").text(item.item_name);
// 					var cell3 = $("<td></td>").text(item.latitude);
// 					var cell4 = $("<td></td>").text(item.longitude);
// 					var cell5 = $("<td></td>").text(item.classBean.class_name);
// 					var row = $("<tr></tr>").append([ cell1, cell2, cell3, cell4, cell5 ]);
// 					table.append(row);

					// 顯示物品圖片列表
					var imageSrc = "${root}item-image/" + item.imageBean[0].image_photo;
// 					alert(imageSrc);
					var itemImage_img = $("<img>", {"id": "img" + count, "class": "item_image_img", "src": imageSrc});
					var itemImage_a = $("<a></a>").attr("href", "${root}item/itemdetail.controller?id=" + item.item_id).append(itemImage_img);
					var itemImage_div = $("<div class='item_image_div'></div>").append(itemImage_a);
					var itemHyperlink_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "'>" + item.item_name + "</a>";
					var itemName_span = $("<span class='item_name_p'></span>").append(itemHyperlink_a);
					var dot_span = $("<span></span>").append("．");
					var itemClassName_span = $("<span></span>").append(item.classBean.class_name);
					var itemLocation_p = $("<p class='item_location_p'></p>").append(item.location);
					var itemText_div = $("<div class='item_text_div'></div>").append(itemName_span).append(dot_span).append(itemClassName_span).append(itemLocation_p);
					var itemInfo_div = $("<div class='item_info_div'></div>").append(itemText_div);
					var itemBean_div = $("<div class='item_bean_div col-sm-12 col-md-6'></div>").attr("id", "item" + count).append(itemImage_div).append(itemInfo_div);
					itemBean_div.appendTo(photo);
// 					itemBean_div.appendTo("$inner_left");
					count++;
				});
// 				alert("itemArray.length = " + itemArray.length);

				for(var i = 0; i < itemArray.length; i++){
					var item_id = itemArray[i][0]
					var item_name = itemArray[i][1];
					var class_name = itemArray[i][2];
					var location = itemArray[i][3]
					var latitude = itemArray[i][4];
					var longitude = itemArray[i][5];
					var image_photo = itemArray[i][6];
					
					// 添加地圖標記
					var itemLatLng = new google.maps.LatLng(latitude, longitude);
					var marker = new google.maps.Marker({
	    				title: item_name,
						position: itemLatLng,
	    				map: map,
	    				icon: "${root}category-icon/" + class_name + ".png"
	    			});
					markerArray.push(marker);
					
					// 資訊視窗
					var contentString =
						'<div id="id_infowindow_div">' + 
							'<div>' +
								'<a href="${root}item/itemdetail.controller?id=' + item_id + '">' +
									'<div id="id_infoimage_div">' +
										'<img id="id_infoimage_img" src="${root}item-image/' + image_photo + '">' + 
									'</div>' +
								'</a>' +
								'<div>' +
									'<div id="id_infotext_div">' +
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotitle_a">' +
											'<div style="float:left">' +
												'<span>' + item_name + '</span>' +
											'</div>' +
										'</a>' +
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
											'<div>' +
												'<span>．</span>' +
												'<span>' + class_name + '</span>' +	
											'</div>' +
										'</a>' +
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
											'<div style="padding-top:4px">' +
												'<p style="width:190px;overflow:hidden;margin:0px">' + location + '</p>' +	
											'</div>' +
										'</a>' +
									'</div>' +
								'</div>' +
							'</div>' +
						'</div>';
					var infoWindow = new google.maps.InfoWindow();
					addInfoWindow(marker, contentString);
				}
				
				// 資訊視窗事件
				function addInfoWindow(marker, contentString) {
//			            var infoWindow = new google.maps.InfoWindow({
//			                content: contentString
//			            });
		            google.maps.event.addListener(marker, 'click', function () {
		            	if(infoWindow){
		            		infoWindow.close();
		            	}
		            	infoWindow.setContent(contentString);
		                infoWindow.open(map, marker);
		            });
		        }
			});
			
			// 移動地圖即時變更物品
			map.addListener('dragend', function() {
				deleteMarkers();
				var bounds = map.getBounds();
				var sw = bounds.getSouthWest();
				var ne = bounds.getNorthEast();
//  			console.log(ne.lat(), ne.lng());
//  			console.log(sw.lat(), sw.lng());
				var boundsString = "lat: " + sw.lat() + " ~ " + ne.lat() + "<br>" +
								   "lng: " + sw.lng() + " ~ " + ne.lng();
				$("#showBounds").html(boundsString);
				$.getJSON("searchItemName.ajax", {
					"searchBar": searchBar,
					"swLat": sw.lat(),
					"swLng": sw.lng(),
					"neLat": ne.lat(),
					"neLng": ne.lng()
				}, function(data){
// 					table.empty();
					photo.empty();
					var count = 1;
					$.each(data, function(index, item){
						
						// 製作物品資訊陣列
						var aItem = [item.item_id, item.item_name, item.classBean.class_name, item.location, item.latitude, item.longitude, item.imageBean[0].image_photo ];
						itemArray.push(aItem);
						
						// 製作物品資訊列表
// 						var cell1 = $("<td></td>").text(item.item_id);
// 						var cell2 = $("<td></td>").text(item.item_name);
// 						var cell3 = $("<td></td>").text(item.latitude);
// 						var cell4 = $("<td></td>").text(item.longitude);
// 						var cell5 = $("<td></td>").text(item.classBean.class_name);
// 						var row = $("<tr></tr>").append([ cell1, cell2, cell3, cell4, cell5 ]);
// 						table.append(row);

						// 顯示物品圖片列表
						var imageSrc = "${root}item-image/" + item.imageBean[0].image_photo;
//	 					alert(imageSrc);
						var itemImage_img = $("<img>", {"id": "img" + count, "class": "item_image_img", "src": imageSrc});
						var itemImage_a = $("<a></a>").attr("href", "${root}item/itemdetail.controller?id=" + item.item_id).append(itemImage_img);
						var itemImage_div = $("<div class='item_image_div'></div>").append(itemImage_a);
						var itemHyperlink_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "'>" + item.item_name + "</a>";
						var itemName_span = $("<span class='item_name_p'></span>").append(itemHyperlink_a);
						var dot_span = $("<span></span>").append("．");
						var itemClassName_span = $("<span></span>").append(item.classBean.class_name);
						var itemLocation_p = $("<p class='item_location_p'></p>").append(item.location);
						var itemText_div = $("<div class='item_text_div'></div>").append(itemName_span).append(dot_span).append(itemClassName_span).append(itemLocation_p);
						var itemInfo_div = $("<div class='item_info_div'></div>").append(itemText_div);
						var itemBean_div = $("<div class='item_bean_div col-sm-12 col-md-6'></div>").attr("id", "item" + count).append(itemImage_div).append(itemInfo_div);
						itemBean_div.appendTo(photo);
						count++;
					});
					
					for(var i = 0; i < itemArray.length; i++){
						var item_id = itemArray[i][0]
						var item_name = itemArray[i][1];
						var class_name = itemArray[i][2];
						var location = itemArray[i][3]
						var latitude = itemArray[i][4];
						var longitude = itemArray[i][5];
						var image_photo = itemArray[i][6];
						
						// 添加地圖標記
						var itemLatLng = new google.maps.LatLng(latitude, longitude);
						var marker = new google.maps.Marker({
		    				title: item_name,
							position: itemLatLng,
		    				map: map,
		    				icon: "${root}category-icon/" + class_name + ".png"
		    			});
						markerArray.push(marker);
						
						// 資訊視窗
						var contentString =
							'<div id="id_infowindow_div">' + 
								'<div>' +
									'<a href="${root}item/itemdetail.controller?id=' + item_id + '">' +
										'<div id="id_infoimage_div">' +
											'<img id="id_infoimage_img" src="${root}item-image/' + image_photo + '">' + 
										'</div>' +
									'</a>' +
									'<div>' +
										'<div id="id_infotext_div">' +
											'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotitle_a">' +
												'<div style="float:left">' +
													'<span>' + item_name + '</span>' +
												'</div>' +
											'</a>' +
											'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
												'<div>' +
													'<span>．</span>' +
													'<span>' + class_name + '</span>' +	
												'</div>' +
											'</a>' +
											'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
												'<div style="padding-top:4px">' +
													'<p style="width:190px;overflow:hidden;margin:0px">' + location + '</p>' +	
												'</div>' +
											'</a>' +
										'</div>' +
									'</div>' +
								'</div>' +
							'</div>';
						var infoWindow = new google.maps.InfoWindow();
						addInfoWindow(marker, contentString);
					}
					
					// 資訊視窗事件
					function addInfoWindow(marker, contentString) {
//				            var infoWindow = new google.maps.InfoWindow({
//				                content: contentString
//				            });
			            google.maps.event.addListener(marker, 'click', function () {
			            	if(infoWindow){
			            		infoWindow.close();
			            	}
			            	infoWindow.setContent(contentString);
			                infoWindow.open(map, marker);
			            });
			        }
				});
			});
		}
		
		// 清除所有地圖標記
		function deleteMarkers() {
			clearMarkers();
			itemArray = [];
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
		

		$(document).ready(function(){
// 			$("#header").load("../header.jsp");
			
			// header
			// 表單驗證
			$('#id_form').validate({
				event: "blur",
				rules: {
					searchBar: "required",
				},
				messages: {
					searchBar: "",
				},
				highlight: function (element) {

				},
	        	unhighlight: function (element) {

	        	},
			});
		});
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>
</body>
</html>