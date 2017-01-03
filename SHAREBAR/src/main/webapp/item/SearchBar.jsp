<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>搜尋物品</title>
<link rel="stylesheet" href="../js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="../js/jquery.validate.min.js"></script>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#map {
	height: 100%;
	width: 50%;
	position: absolute;
	right: 0px;
}
</style>
</head>
<body>
	<div style="float: left">
		<form id="id_form" action="<c:url value="/item/search.controller" />" method="get">
			<table>
				<tr>
					<td>
						<select id="switch" name="searchSelector">
							<option value="location">地區</option>
							<option value="itemName">物品</option>
						</select>
					</td>
					<td><input type="text" id="address" name="searchBar" size="50" placeholder=""
						style="width: 400px" /></td>
					<td><input type=submit id="send" value="確定" /></td>
				</tr>
			</table>
			<table id="latlng"></table>
		</form>
	</div>
	<div id="map" style='display:none'></div>
	
	<script>
		var map;
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
// 	    	$("#address").on("autocompletechange", function(){
// 				var searchBar = $("#address").val();
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
		    input = document.getElementById('address');
// 			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
			googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			geocoder = new google.maps.Geocoder();
		}

		// 切換自動完成
		$("select").on("change", function() {
// 			alert($("select").val());
			if($("select").find(":selected").val() === "itemName") {
				$("#address").autocomplete({source: availableTags});
				google.maps.event.clearInstanceListeners(input);
				$('#address').autocomplete('enable');
			} else {
				$('#address').autocomplete('disable');
				var options = {
// 		    			types: ['establishment']
						types: ['geocode']
// 		    			types: ['address']
		    		};
				googleAutocomplete = new google.maps.places.Autocomplete(input, options);
			}
		});
		
		// 更改搜尋條件
		$("#address").on("change", function(event){
// 			event.preventDefault();
			var searchSelector = $("#switch").find(":selected").val();
			alert(searchSelector);
			var searchBar = $("#address").val();
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
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJznZ1ht-uJFa-tBJBpYYtzQ2609ba2Eg&libraries=places&callback=initMap&language=zh-TW"></script>
</body>
</html>