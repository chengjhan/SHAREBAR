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
<link rel=stylesheet type="text/css" href="../css/share.css">
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
}

#left_top {
	width: 100%;
	height: 80px;
	padding: 15px;
}

#left_content {
	width: 100%;
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
 	float: left;
/* 	background-color: #FCFCFC; */
 	margin-bottom: 15px;
}

.item_image_div {
	width: 100%;
	z-index: 1;
	position: relative;
}

.item_image_img {
	width: 100%;
}

.item_member_div {
	width: 20%;
	height : 20%;
	z-index: 200;
	position: absolute;
	left: 10px;
	bottom: 10px;
	border-radius: 99em;
	border: 2px white solid;
}

.item_member_img {
	width:100%;
	border-radius:99em;
}

.item_follow_div {
	width: 15%;
	height : 15%;
	z-index: 200;
	position: absolute;
	top: 5px;
	right: 5px;
	border-radius: 99em;
}

.item_follow_img {
	width:100%;
	border-radius:99em;
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

.item_name_a:link {
	color: #444444;
	font-size: 16px;
	text-decoration: none;
}

.item_name_a:visited {
	color: #444444;
}

.item_name_a:hover {
	color: #444444;
	text-decoration: underline;
}

.item_name_a:active {
	color: #444444;
}

.item_text_a:link {
	color: #888888;
	text-decoration: none;
}

.item_text_a:visited {
	color: #888888;
}

.item_text_a:hover {
	color: #888888;
	text-decoration: none;
}

.item_text_a:active {
	color: #888888;
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
	color: #444444;
	text-decoration: none;
}

.infotitle_a:visited {
	color: #444444;
}

.infotitle_a:hover {
	color: #444444;
	text-decoration: underline;
}

.infotitle_a:active {
	color: #444444;
}

.infotext_a:link {
	color: #888888;
	text-decoration: none;
}

.infotext_a:visited {
	color: #888888;
}

.infotext_a:hover {
	color: #888888;
	text-decoration: none;
}

.infotext_a:active {
	color: #888888;
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
					<select id="id_select" name="searchSelector" class="form-control">
						<option value="location">地區</option>
						<option value="itemName">物品</option>
					</select>
					<div class="form-group">
						<input type="text" id="id_search" name="searchBar" class="form-control" placeholder="" style="width: 300px" /></td>
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
				<div id="left_top">
					<div>
						<div style="font-size:16px;margin-bottom:5px">
							<div style="float:left">
								<span>搜尋條件</span>
								<span>．</span>
							</div>
							<div style="float:left">
								<span>物品</span>
								<span>．</span>
							</div>
							<div>
								<span>${searchBar}</span>
							</div>
						</div>
						<div style="font-size:14px">
							<div style="float:left">
								<span>現在位置 </span>
								<span>．</span>
								<span id="id_center_span"></span>
							</div>
							<div style="position:absolute;right:30px;">
								<span>共 </span>
								<span id="id_number_span"></span>
								<span> 筆結果</span>
							</div>
						</div>
					</div>
				</div>
				<div id="left_content"></div>
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
// 			    	types: ['establishment']
					types: ['geocode']
//			   		types: ['address']
		    	};
				googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			}
		});
		
		// 更改搜尋條件
		$("#id_search").on("change", function(event){
//			event.preventDefault();
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
							var trLatLnf = $("<tr style='display:none'></tr>").append(tdLatLng);
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
// 		    	bounds: defaultBounds,
// 		    	types: ['establishment']
// 		    	types: ['address']
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
				zoom : 8,
				minZoom : 2
			});
			
			// 由搜尋列第一次搜尋
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
// 			var table = $("#itemList>tbody");
			var photo = $("#left_content")
			var searchBar = "${searchBar}";
			var number = $("#id_number_span");
			var currentLat = ${currentLat};
			var currentLng = ${currentLng};
			var currentLatLng = { lat: currentLat, lng: currentLng };
			var centerLocation = $("#id_center_span");
			
			// 取得現在地址
			centerLocation.empty();
			geocoder.geocode({'location': currentLatLng}, function(results, status) {
				if (status === google.maps.GeocoderStatus.OK) {
					if (results[0]) {
//						alert(results[0].formatted_address);
						centerLocation.append(results[0].formatted_address);
					} 
				}
			});
			
			$.getJSON("searchItemName.ajax", {
				"searchBar": searchBar,
				"swLat": swLat,
				"swLng": swLng,
				"neLat": neLat,
				"neLng": neLng
			}, function(data){
// 				table.empty();
// 				photo.empty();
				var count = 0;
				
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
					var itemMember_img = "<img src='${root}profileImages/" + item.member_id.photo + "' class='item_member_img'>";
					var itemMember_div = $("<div class='item_member_div'></div>").append(itemMember_img);
					var itemMember_a = $("<a></a>").attr("href", "${root}member/profile.controller?id=" + item.member_id.member_no).append(itemMember_div);					
					
					var itemFollow_img;
					var itemFollow_div;
					var itemFollow_a;
					
					var user = ${user.member_no}
					console.log(user);
					if(user == undefined){
						user = 0;
// 						alert(user)
					} else if(user != 0){
						if(user != item.member_id.member_no){
// 							alert(item.member_id.member_no)
							itemFollow_img = "<img src='${root}item-icon/follow.png' id='id_item_follow_img' class='item_follow_img'>";
// 							alert(item.member_id.member_no + "," + item.follow_items.length)
							for(var i = 0; i < item.follow_items.length; i++){
								if(item.follow_items[i] != null){
// 									alert(item.follow_items[i].member_id.member_no);
									if(user == item.follow_items[i].member_id.member_no){
// 										alert(item.follow_items[i].status)
										if(item.follow_items[i].status == 1){
											itemFollow_img = "<img src='${root}item-icon/followed.png' id='id_item_follow_img' class='item_follow_img'>";
										}
									}
								}
							}
							itemFollow_div = $("<div class='item_follow_div'></div>").append(itemFollow_img);
							itemFollow_a = $("<a></a>").attr("class", "id_item_follow_a").attr("value", item.item_id).append(itemFollow_div);						
						}
					}
					
					var itemImage_div = $("<div class='item_image_div'></div>").append(itemImage_a).append(itemMember_a).append(itemFollow_a);
					var itemItemName_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "' class='item_name_a'>" + item.item_name + "</a>";
					var itemName_span = $("<span class='item_name_p'></span>").append(itemItemName_a);
					var dot_span = $("<span></span>").append("．");
					var itemClassName_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "' class='item_text_a'>" + item.classBean.class_name + "</a>";
					var itemClassName_span = $("<span></span>").append(itemClassName_a);
					var itemLocation_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "' class='item_text_a'>" + item.location + "</a>";
					var itemLocation_p = $("<p class='item_location_p'></p>").append(itemLocation_a);
					var itemText_div = $("<div class='item_text_div'></div>").append(itemName_span).append(dot_span).append(itemClassName_span).append(itemLocation_p);
					var itemInfo_div = $("<div class='item_info_div'></div>").append(itemText_div);
					var itemBean_div = $("<div class='item_bean_div col-sm-12 col-md-6'></div>").attr("id", count).append(itemImage_div).append(itemInfo_div);
					itemBean_div.appendTo(photo);
					count++;
				});
				number.append(count);
// 				alert("itemArray.length = " + itemArray.length);

				for(var i = 0; i < itemArray.length; i++){
					var item_id = itemArray[i][0];
					var item_name = itemArray[i][1];
					var class_name = itemArray[i][2];
					var location = itemArray[i][3];
					var latitude = itemArray[i][4];
					var longitude = itemArray[i][5];
					var image_photo = itemArray[i][6];
					
					// 添加地圖標記
					var itemLatLng = new google.maps.LatLng(latitude, longitude);
					var marker = new google.maps.Marker({
	    				title: item_name,
						position: itemLatLng,
	    				map: map,
	    				visible: true,
	    				icon: "${root}category-icon/" + class_name + ".png"
	    			});
					
					// 製作地圖標記陣列
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
										'<div style="float:left;padding-bottom:4px">' +
											'<span>' +
												'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotitle_a">' + item_name + '</a>' +
										 	'</span>' +
										'</div>' +	
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
											'<div style="float:left">' +
												'<span>．</span>' +
												'<span>' + class_name + '</span>' +	
											'</div>' +
										'</a>' +
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
											'<div>' +
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
// 			map.addListener('dragend', moveMap);
// 			map.addListener('zoom_changed', moveMap);
			map.addListener('idle', moveMap);

			function moveMap() {
				// 清除所有地圖標記
				deleteMarkers();
				
				// 取得地圖西南及東北經緯度
				var bounds = map.getBounds();
				var sw = bounds.getSouthWest();
				var ne = bounds.getNorthEast();
//  			console.log(ne.lat(), ne.lng());
//  			console.log(sw.lat(), sw.lng());
// 				var boundsString = "lat: " + sw.lat() + " ~ " + ne.lat() + "<br>" +
// 								   "lng: " + sw.lng() + " ~ " + ne.lng();
// 				$("#showBounds").html(boundsString);

				// 取得地圖中心經緯度
				var center = map.getCenter();
				var centerLat = center.lat();
				var centerLng = center.lng();
// 				alert(centerLat + "," + centerLng);
				var centerLatLng = { lat: centerLat, lng: centerLng }
// 				alert(centerLatLng);
				
				// 取得地圖中心地址
				centerLocation.empty();
				geocoder.geocode({'location': centerLatLng}, function(results, status) {
					if (status === google.maps.GeocoderStatus.OK) {
						if (results[0]) {
// 							alert(results[0].formatted_address);
							centerLocation.append(results[0].formatted_address);
						} 
					}
				});
				
				$.getJSON("searchItemName.ajax", {
					"searchBar": searchBar,
					"swLat": sw.lat(),
					"swLng": sw.lng(),
					"neLat": ne.lat(),
					"neLng": ne.lng()
				}, function(data){
// 					table.empty();
					photo.empty();
					number.empty();
					var count = 0;
					
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
// 	 					alert(imageSrc);
						var itemImage_img = $("<img>", {"id": "img" + count, "class": "item_image_img", "src": imageSrc});
						var itemImage_a = $("<a></a>").attr("href", "${root}item/itemdetail.controller?id=" + item.item_id).append(itemImage_img);
						var itemMember_img = "<img src='${root}profileImages/" + item.member_id.photo + "' class='item_member_img'>";
						var itemMember_div = $("<div class='item_member_div'></div>").append(itemMember_img);
						var itemMember_a = $("<a></a>").attr("href", "${root}member/profile.controller?id=" + item.member_id.member_no).append(itemMember_div);					
						
						var itemFollow_img;
						var itemFollow_div;
						var itemFollow_a;
						
						var user = ${user.member_no}
						console.log(user);
						if(user == undefined){
							user = 0;
//	 						alert(user)
						} else if(user != 0){
							if(user != item.member_id.member_no){
// 	 							alert(item.member_id.member_no)
								itemFollow_img = "<img src='${root}item-icon/follow.png' id='id_item_follow_img' class='item_follow_img'>";
// 	 							alert(item.member_id.member_no + "," + item.follow_items.length)
								for(var i = 0; i < item.follow_items.length; i++){
									if(item.follow_items[i] != null){
//	 									alert(item.follow_items[i].member_id.member_no);
										if(user == item.follow_items[i].member_id.member_no){
//	 										alert(item.follow_items[i].status)
											if(item.follow_items[i].status == 1){
												itemFollow_img = "<img src='${root}item-icon/followed.png' id='id_item_follow_img' class='item_follow_img'>";
											}
										}
									}
								}
								itemFollow_div = $("<div class='item_follow_div'></div>").append(itemFollow_img);
								itemFollow_a = $("<a></a>").attr("class", "id_item_follow_a").attr("value", item.item_id).append(itemFollow_div);						
							}
						}
						
						var itemImage_div = $("<div class='item_image_div'></div>").append(itemImage_a).append(itemMember_a).append(itemFollow_a);
						var itemItemName_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "' class='item_name_a'>" + item.item_name + "</a>";
						var itemName_span = $("<span class='item_name_p'></span>").append(itemItemName_a);
						var dot_span = $("<span></span>").append("．");
						var itemClassName_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "' class='item_text_a'>" + item.classBean.class_name + "</a>";
						var itemClassName_span = $("<span></span>").append(itemClassName_a);
						var itemLocation_a = "<a href='${root}item/itemdetail.controller?id=" + item.item_id + "' class='item_text_a'>" + item.location + "</a>";
						var itemLocation_p = $("<p class='item_location_p'></p>").append(itemLocation_a);
						var itemText_div = $("<div class='item_text_div'></div>").append(itemName_span).append(dot_span).append(itemClassName_span).append(itemLocation_p);
						var itemInfo_div = $("<div class='item_info_div'></div>").append(itemText_div);
						var itemBean_div = $("<div class='item_bean_div col-sm-12 col-md-6'></div>").attr("id", count).append(itemImage_div).append(itemInfo_div);
						itemBean_div.appendTo(photo);
						count++;
					});
					number.append(count);
					
					for(var i = 0; i < itemArray.length; i++){
						var item_id = itemArray[i][0];
						var item_name = itemArray[i][1];
						var class_name = itemArray[i][2];
						var location = itemArray[i][3];
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
						
						// 製作地圖標記陣列
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
										'<div style="float:left;padding-bottom:4px">' +
											'<span>' +
												'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotitle_a">' + item_name + '</a>' +
										 	'</span>' +
										'</div>' +	
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
											'<div style="float:left">' +
												'<span>．</span>' +
												'<span>' + class_name + '</span>' +	
											'</div>' +
										'</a>' +
										'<a href="${root}item/itemdetail.controller?id=' + item_id + '" class="infotext_a">' +
											'<div>' +
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
			}
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
				highlight: function (element) {

				},
	        	unhighlight: function (element) {

	        	},
			});
			
			// body
			// 標記變色-全部變色
// 			$(document).on("mouseover", ".item_bean_div", function(){
// 				for(var i = 0; i < itemArray.length; i++){
// 					var class_name = itemArray[i][2];
// 					alert(class_name);
// 					var marker = markerArray[i];
// 					marker.setIcon({
// 						url: "${root}category-icon/" + class_name + "a.png"
// 				    });
// 					marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);
// 				}
// 			});
// 			$(document).on("mouseout", ".item_bean_div", function(){
// 				for(var i = 0; i < itemArray.length; i++){
// 					var class_name = itemArray[i][2];
// 					alert(class_name);
// 					var marker = markerArray[i];
// 					marker.setIcon({
// 						url: "${root}category-icon/" + class_name + ".png"
// 				    });
// 					marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);
// 				}
// 			});

			// 標記變色-個別變色
			$(document).on("mouseover", ".item_bean_div", function(){
// 				alert(itemArray.length);
				var $this = $(this);
// 				alert($this);
				$this_id = $this.attr("id");
// 				alert($this_id);
				var class_name = itemArray[$this_id][2];
// 				alert(class_name);
				var marker = markerArray[$this_id];
				marker.setIcon({
					url: "${root}category-icon/" + class_name + "a.png"
			    });
				marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);
			});
			$(document).on("mouseout", ".item_bean_div", function(){
				var $this = $(this);
				$this_id = $this.attr("id");
// 				alert($this_id);
				var class_name = itemArray[$this_id][2];
// 				alert(class_name);
				var marker = markerArray[$this_id];
				marker.setIcon({
					url: "${root}category-icon/" + class_name + ".png"
			    });
				marker.setZIndex(google.maps.Marker.MAX_ZINDEX + 1);
			});
			
			// 追蹤按鈕-愛心變色
			$(document).on("mouseover", "#id_item_follow_img", function(){
				if($(this).attr("src") == "${root}item-icon/follow.png"){
					$(this).removeAttr("src").attr("src", "${root}item-icon/follow_a.png");					
				}
			});
			$(document).on("mouseout", "#id_item_follow_img", function(){
				if($(this).attr("src") == "${root}item-icon/follow_a.png"){
					$(this).removeAttr("src").attr("src", "${root}item-icon/follow.png");					
				}
			});
			$(document).on("click", "#id_item_follow_img", function(){
				if($(this).attr("src") == "${root}item-icon/follow_a.png" || $(this).attr("src") == "${root}item-icon/follow.png"){
					$(this).removeAttr("src").attr("src", "${root}item-icon/followed.png");					
				}else{
					$(this).removeAttr("src").attr("src", "${root}item-icon/follow.png");
				}
			});
			
			// 追蹤按鈕-修改資料庫
			$(document).on("click", ".id_item_follow_a", function(){
				var $this = $(this);
				var item_id = $this.attr("value");
				$.get("followItem.do", {
					"MemberID": "${user.member_no}",
					"ItemID": item_id
				},
				function(data){
// 					if(data == 1) {
// 						$("$this a").attr("img", "${root}item-icon/followed.png");
// 					} else {
// 						$("$this a").attr("img", "${root}item-icon/follow.png");
// 					}
				});
			});
		});
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>
</body>
</html>