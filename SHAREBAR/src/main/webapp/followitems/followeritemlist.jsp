<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="js/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<!-- <script src="js/bootstrap5/js/bootstrap.min.js"></script> -->
<script type="text/javascript">

	$(function(){
		
// 		$("p > a").hover(over);
// 		function over(){
// 			if($(this).attr("following") == 1){
// 				$(this).toggleClass("btn-danger");	
// 			}else{
// 				$(this).toggleClass("btn-danger");
// 			}
			
// 		}
		
// 		function out(){
// 			if($(this).attr("following") == 1){
// 				$(this).toggleClass("btn-danger");	
// 			}else{
// 				$(this).toggleClass("btn-danger");
// 			}
// 		}

		$('div.box').hover(over);
		function over(){
			if(($(this).find('a').attr("following")) == 1){
				$(this).find('a').toggleClass("btn-danger");	
			}
		}
		
		
// 		//測試抓取 following
// 		$("p > a").click(function(){
// 			alert("following:" + $(this).attr("following"));
// 		})
		
		
		//追隨按鈕
		$("p > a").click(function(){
			var change = 0;
		$.get("followitems/followItem.controller",{"MemberID":"${followitembeans[0].memberBean.member_no}","ItemID":$(this).attr("value")},
				function(data){
// 					alert("result:"+ data);
// 					$(this).find('a').attr("following",data);
					change = data;
					$(this).find('a').attr("following","1");
// 					$(this).toggleClass("btn-danger");
					})
		})
		
		
		
	})
	
	
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.textellipsis
	{text-overflow:ellipsis;
	 overflow:hidden;
	 white-space: nowrap;}
	.followerimg
	{
 	float:right; 
	position: relative;
	right: 0px;
	bottom: 30px;
/* 	height: 30px; */

	}
	.box:hover a{display:block;}
	.box a{display:none;}
			  
</style>
</head>
<body>
	<div class="container">
		<h1>這邊要放圖片</h1>

		<h3>hi,${followitembeans[0].memberBean.nickname}</h3>

		

		<p>${followitembeans[0]}</p>
		<p>${followitembeans[0].itemBean.item_name}</p>
		<p>${followitembeans[0].itemBean.item_id}</p>
		<p>${followitembeans[0].status}</p>
		<p>meberid , ${followitembeans[0].memberBean.member_no}</p>

		<p>${header.host}</p>

		<nav>
		<ul class="pagination">
			<li><a href="#"><span aria-hidden="true">&laquo;</span><span
					class="sr-only">Previous</span></a></li>
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#"><span aria-hidden="true">&raquo;</span><span
					class="sr-only">Next</span></a></li>
		</ul>
		</nav>

		<div class="row">
			<c:forEach var="FollowItemsBean" items="${followitembeans}">
			<div class="col-sm-3 col-md-2">
				<div class="thumbnail">
					<img data-src="holder.js/300x300">
					<div class="caption box">
						<p class="textellipsis"> ${FollowItemsBean.itemBean.item_name}</p>
						<p>
							<a href="#" class="btn btn-default followerimg" value="${FollowItemsBean.itemBean.item_id}" following="${FollowItemsBean.status}" >
							 	<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
							</a>
						</p>
					</div>
				</div>
			</div>
			</c:forEach>
			
			<div class="col-sm-3 col-md-2">
				<div class="thumbnail">
					<img data-src="holder.js/300x300">
					<div class="caption box">
						<p class="textellipsis"> 這是假資料1</p>
						<p>
							<a href="#" class="btn btn-default followerimg" value="99" following="0" >
							 	<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
							</a>
						</p>
					</div>
				</div>
			</div>
			
<%-- 			<c:forEach var="ItemBean" items="${itembeans}"> --%>
<%-- 			<p>${ItemBean.item_name}</p> --%>
<%-- 			</c:forEach> --%>
			
		</div>




	</div>
	</div>


</body>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>

</html>