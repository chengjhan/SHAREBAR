<%@page import="javax.persistence.metamodel.SetAttribute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="js/Carousel-Plugin-flexisel/css/style.css"> -->
<link rel="stylesheet" href="js/slick/slick.css">
<link rel="stylesheet" href="js/slick/slick-theme.css">
<link rel="stylesheet" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="js/jquery-ui-1.12.1.custom/jquery-ui.css"/>
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="js/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<!-- <script -->
<!--   src="https://code.jquery.com/jquery-3.1.1.min.js" -->
<!--   integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" -->
<!--   crossorigin="anonymous"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script> -->
<script src="js/slick/slick.js"></script>
<!-- <script src="js/Carousel-Plugin-flexisel/js/jquery.flexisel.js"></script> -->
<!-- <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script> -->
<c:url value="/" var="root"></c:url>

<head>
<style>
.textellipsis{
	 text-overflow:ellipsis;
	 overflow:hidden;
	 white-space: nowrap;
}

    * {
      box-sizing: border-box;
    }

    .slick-slider {
        width: 50%;
        margin-left:auto;
        margin-right:auto;
    }

    .slick-slide {
      margin: 0px 20px;
    }

    .slick-slide img {
    width: 100%;

    }

    .slick-prev:before,
    .slick-next:before {
        color: black;
    }
.boxIan {
    position: relative;
    width:    100%; /* desired width */
}
.boxIan:before {
    content:     "";
    display:     block;
    padding-top: 100%; /* initial ratio of 1:1*/
}

.contentIan {
    position: absolute;
    height: 100%;
    top:      0;
    left:     0;
    bottom:   0;
    right:    0;
}
.item_slide .contentIan {
    position: absolute;
    height: 80%;
    top:      0;
    left:     0;
    bottom:   0;
    right:    0;
}
h3 {
    font-size: 36px;
    margin: 20px auto;
    text-align: center;
}
.intro{
	position:absolute;
	bottom:0;
	right:0;
	background-color:black;
	color:white;
	width:100%;
}





</style>
<title>Home Page</title>
</head>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="item.model.ItemBean" %>
<%@ page import="item.model.ItemService" %>
<%@ page import="category.model.*" %>
<%
WebApplicationContext context = (WebApplicationContext) WebApplicationContextUtils.getWebApplicationContext(application);
ItemService itemService = (ItemService) context.getBean("itemService");
ClassService classService = (ClassService) context.getBean("classService");
List<ClassBean> classBeans = classService.selectByRandom();
List<ItemBean> beans = itemService.selectByNew();
pageContext.setAttribute("items",beans);
pageContext.setAttribute("classes",classBeans);
%>

<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="wrap">

<div class="container coverflow">
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="<%=request.getContextPath()%>/img/sharing.jpg" alt="...">
      <div class="carousel-caption">
      <div>
       <h3>歡迎來到SHARE BAR</h3>
       <p>開始分享吧!</p>
      </div>
      </div>
    </div>
    <div class="item">
      <img src="<%=request.getContextPath()%>/img/sharing2.jpg" alt="...">
      <div class="carousel-caption">
      <h3>清楚的地圖資訊</h3>
      <p>來自世界個地的分享</p>
      </div>
    </div>
    <div class="item">
      <img src="<%=request.getContextPath()%>/img/sharing3.jpg" alt="...">
      <div class="carousel-caption">
       <h3>隨時隨地可以分享</h3>
       <p>使用手機也可以輕鬆分享</p>
      </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</div>
 
<h3>Category <small>Choose the category you want!</small></h3>
<div class="category_slide">
<c:forEach var="category" items="${classes}">
<div class="boxIan">
<a href="${root}item/SearchClassName.jsp?id=${category.class_id}&name=${category.class_name}">
<img class="contentIan" data-lazy="${root}category-image/${category.image}">
</a>
</div>
</c:forEach>
</div>

<h3>Items <small>Find newest items here!</small></h3>
<div class="item_slide">
<c:forEach var="item" items="${items}">
<div class="boxIan">
<a href="${root}item/itemdetail.controller?id=${item.item_id}">
<c:forEach var="image" items="${item.imageBean}" varStatus="stat">
	<c:if test="${stat.first}">
			<img alt="item_image" data-lazy="${root}item-image/${image.image_photo}" class="contentIan">
	</c:if>
</c:forEach>
</a>
<div class="intro textellipsis"><span class="glyphicon glyphicon-gift"></span>${item.item_name} <br><span class="glyphicon glyphicon-map-marker"></span> ${item.location} </div>
</div>
</c:forEach>
</div>


</div><!-- end of wrap -->
<script type="text/javascript">
$(".category_slide").slick({
	  lazyLoad: 'ondemand',
	  slidesToShow: 3,
	  slidesToScroll: 1
	});
$(".item_slide").slick({
	  lazyLoad: 'ondemand',
	  slidesToShow: 3,
	  slidesToScroll: 1
	});
$(function(){
// 	$('.coverflow').css('margin-top','-20px');
	$('.coverflow').css('max-width',$('.coverflow img').width());
})
</script>
<c:import url="/footer.jsp"></c:import>
</body>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>

</html>
