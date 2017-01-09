<%@page import="javax.persistence.metamodel.SetAttribute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="js/Carousel-Plugin-flexisel/css/style.css">
<script
  src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="js/Carousel-Plugin-flexisel/js/jquery.flexisel.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkzrteoqOx4_KZZAHCXBE41sXnaXOzrRc&libraries=places&callback=initMap&language=zh-TW"></script>

<head>
<style>
.textellipsis{
	 text-overflow:ellipsis;
	 overflow:hidden;
	 white-space: nowrap;
}

div.img_container{
	width: 105%;
    height: 80%;
    padding: 0px;
/*     border:1px solid gray;  /* you can remove this */ */
/*     box-sizing:border-box; /* you can remove this */ */
    display:inline-block;
}
.item_container{
	width:100%;
	height:100%;
}
li.flexisel_li{
	text-align:center;
	vertical-align:center;
}
#flexi_intro{
	margin-left:auto;
	margin-right:auto;
	text-align:center;
}
div.nbs-flexisel-inner{
	border: 0px solid #ccc;
}
div.item_list{
	border:none;
}
div.item_descrip{
	margin-left:25px;
}
.nbs-flexisel-item img{
    max-width: 60%;
    cursor: pointer;
    position: relative;
    margin: 10px;
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
// List<String> classID = new ArrayList();
// for(ClassBean temp : classBeans){
// 	String Classid = ""+temp.getClass_id();
// 	out.println(Classid);
// 	classID.add(Classid);
// }
// out.println(classBeans);
List<ItemBean> beans = itemService.selectByNew();
pageContext.setAttribute("items",beans);
pageContext.setAttribute("classes",classBeans);
%>

<body>
<jsp:include page="header.jsp"></jsp:include>
<script>
// if (navigator.geolocation) {
// 	navigator.geolocation.getCurrentPosition(success, error);
// }
// console.log(bounds);
</script>

<%-- <jsp:include page="header.jsp"></jsp:include> --%>
<!-- <div id="header"></div> -->

<div class="wrap">

<div id="flexisel_container" style="height:300px">
<ul id="classflexi"> 
	<c:forEach var="category" items="${classes}">
		<li class="flexisel_li">
		<div class="thumbnail item_list">
		<div class="item_container" style="width:87%">
		<a href="${root}item/searchClassName.ajax?class_id=${category.class_id}&">
		</a>
		<figcaption class="textellipsis">
		<div class="item_descrip">
		<span class="glyphicon glyphicon-file"></span> ${category.class_name}<br>
		</div>
		</figcaption>
		</div>
		</li>
	</c:forEach>                                                        
</ul>
</div>






<div class="clearout"></div>
<div>
<legend id="flexi_intro">Find Newest stuff here free!</legend>
</div>
<div id="flexisel_container" style="height:300px">
<ul id="itemflexi"> 
	<c:forEach var="item" items="${items}">
		<li class="flexisel_li">
		<div class="thumbnail class_list">
		<div class="class_container" style="width:87%">
		<a href="${root}item/itemdetail.controller?id=${item.item_id}">
			<div class="img_container">
				<img alt="item_image" src="${root}item-image/${image.image_photo}" class="follow_list">
			</div>
		</a>
		<figcaption class="textellipsis">
		<div class="item_descrip">
		<span class="glyphicon glyphicon-file"></span> ${item.item_name}<br>
		<span class="glyphicon glyphicon-home"></span> ${item.location}
		</div>
		</figcaption>
		</div>
		</li>
	</c:forEach>                                                        
</ul>
</div>

<script type="text/javascript">
$(function(){
    $("#itemflexi").flexisel({
        visibleItems: 3,
        itemsToScroll: 3,
        animationSpeed: 200,
        infinite: false,
        navigationTargetSelector: null,
        autoPlay: {
            enable: false,
            interval: 3000,
            pauseOnHover: true
        },
        responsiveBreakpoints: { 
            portrait: { 
                changePoint:480,
                visibleItems: 3,
                itemsToScroll: 3
            }, 
            landscape: { 
                changePoint:640,
                visibleItems: 3,
                itemsToScroll: 3
            },
            tablet: { 
                changePoint:768,
                visibleItems: 4,
                itemsToScroll: 4
            }
        }
    });
    
    $("#classflexi").flexisel({
        visibleItems: 3,
        itemsToScroll: 3,
        animationSpeed: 200,
        infinite: false,
        navigationTargetSelector: null,
        autoPlay: {
            enable: false,
            interval: 3000,
            pauseOnHover: true
        },
        responsiveBreakpoints: { 
            portrait: { 
                changePoint:480,
                visibleItems: 3,
                itemsToScroll: 3
            }, 
            landscape: { 
                changePoint:640,
                visibleItems: 3,
                itemsToScroll: 3
            },
            tablet: { 
                changePoint:768,
                visibleItems: 4,
                itemsToScroll: 4
            }
        }
    });
	
});
</script>
<</div>
<c:import url="/footer.jsp"></c:import>
</body>
</html>
