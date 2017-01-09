<%@page import="javax.persistence.metamodel.SetAttribute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
	width:75%;
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
    max-width: 95%;
    cursor: pointer;
    position: relative;
    margin: 10px;
}
}
</style>
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
<title>Home Page</title>
</head>
<body>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="item.model.ItemBean" %>
<%@ page import="item.model.ItemService" %>
<%
WebApplicationContext context = (WebApplicationContext) WebApplicationContextUtils.getWebApplicationContext(application);
ItemService itemService = (ItemService) context.getBean("itemService");
List<ItemBean> beans = itemService.selectByNew();
pageContext.setAttribute("items",beans);
%>


<c:import url="header.jsp"></c:import>
<%-- <jsp:include page="header.jsp"></jsp:include> --%>
<!-- <div id="header"></div> -->
<div class="wrap">
<div class="clearout"></div>
<div>
<legend id="flexi_intro">Find Newest stuff here free!</legend>
</div>
<div id="flexisel_container">
<ul id="flexiselDemo1"> 
	<c:forEach var="item" items="${items}">
		<li class="flexisel_li">
		<div class="thumbnail item_list">
		<figure class="item_container" style="width:87%">
		<a href="${root}item/itemdetail.controller?id=${item.item_id}">
		<c:forEach var="image" items="${item.imageBean}" varStatus="stat">
				<c:if test="${stat.first}">
					<div class="img_container">
						<img alt="item_image" src="${root}item-image/${image.image_photo}" class="follow_list">
					</div>
				</c:if>
		</c:forEach>
		</a>
		<figcaption class="textellipsis">
		<div class="item_descrip">
		<span class="glyphicon glyphicon-file"></span> ${item.item_name}<br>
		<span class="glyphicon glyphicon-home"></span> ${item.location}
		</div>
		</figcaption>
		</figure>
		</li>
	</c:forEach>                                                        
</ul>
</div>

<script type="text/javascript">
$(function(){
    $("#flexiselDemo1").flexisel({
        visibleItems: 5,
        itemsToScroll: 2,
        animationSpeed: 500,
        infinite: true,
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
