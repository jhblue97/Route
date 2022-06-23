<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../include/header.jsp" %>


<%@ page import="main.java.dao.UserDAO"%>  
<%@ page import="main.java.dto.Users"%>  

<style>
body {

background-color: bisque;
}
.carousel {
  position: relative;
}
.carousel-item img {
  object-fit: cover;
}
#carousel-thumbs {
  background: rgba(255,255,255,.3);
  bottom: 0;
  left: 0;
  padding: 0 50px;
  right: 0;
}
#carousel-thumbs img {
  border: 5px solid transparent;
  cursor: pointer;
}
#carousel-thumbs img:hover {
  border-color: rgba(255,255,255,.3);
}
#carousel-thumbs .selected img {
  border-color: #fff;
}
.carousel-control-prev,
.carousel-control-next {
  width: 50px;
}
@media all and (max-width: 767px) {
  .carousel-container #carousel-thumbs img {
    border-width: 3px;
  }
}
@media all and (min-width: 576px) {
  .carousel-container #carousel-thumbs {
    position: absolute;
  }
}
@media all and (max-width: 576px) {
  .carousel-container #carousel-thumbs {
    background: #ccccce;
  }
}

</style>
${user.getUserName() }
Route 


<div class="container mt-5">
<div class="carousel-container position-relative row">
  
<!-- Sorry! Lightbox doesn't work - yet. -->
  
<div id="myCarousel" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active" data-slide-number="0">
      <img src="/resources/images/route_main.png" class="d-block w-100" alt="..." data-remote="https://source.unsplash.com/Pn6iimgM-wo/" data-type="image" data-toggle="lightbox" data-gallery="example-gallery">
    </div>
    <div class="carousel-item" data-slide-number="1">
      <img src="/resources/images/ryoukryou.png" class="d-block w-100" alt="..." data-remote="https://source.unsplash.com/tXqVe7oO-go/" data-type="image" data-toggle="lightbox" data-gallery="example-gallery">
    </div>
    <div class="carousel-item" data-slide-number="2">
      <img src="/resources/images/route2.png" class="d-block w-100" alt="..." data-remote="https://source.unsplash.com/qlYQb7B9vog/" data-type="image" data-toggle="lightbox" data-gallery="example-gallery">
    </div>
    <div class="carousel-item" data-slide-number="3">
      <img src="/resources/images/route3.png" class="d-block w-100" alt="..." data-remote="https://source.unsplash.com/QfEfkWk1Uhk/" data-type="image" data-toggle="lightbox" data-gallery="example-gallery">
    </div>
  </div>
</div>

<!-- Carousel Navigation -->
<div id="carousel-thumbs" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <div class="row mx-0">
        <div id="carousel-selector-0" class="thumb col-4 col-sm-2 px-1 py-2 selected" data-target="#myCarousel" data-slide-to="0">
          <img src="/resources/images/route_main.png" class="img-fluid" alt="...">
        </div>
        <div id="carousel-selector-1" class="thumb col-4 col-sm-2 px-1 py-2" data-target="#myCarousel" data-slide-to="1">
          <img src="/resources/images/ryoukryou.png" class="img-fluid" alt="...">
        </div>
        <div id="carousel-selector-2" class="thumb col-4 col-sm-2 px-1 py-2" data-target="#myCarousel" data-slide-to="2">
          <img src="/resources/images/route2.png" class="img-fluid" alt="...">
        </div>
        <div id="carousel-selector-3" class="thumb col-4 col-sm-2 px-1 py-2" data-target="#myCarousel" data-slide-to="3">
          <img src="/resources/images/route3.png" class="img-fluid" alt="...">
        </div>
      </div>
    </div>
    <div class="carousel-item">
      <div class="row mx-0">
        <div class="col-2 px-1 py-2"></div>
        <div class="col-2 px-1 py-2"></div>
      </div>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carousel-thumbs" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carousel-thumbs" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

</div> <!-- /row -->
</div> <!-- /container -->



<div id="map" style="width:500px;height:400px;"></div>

	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=402685406ebee4655fe582f2104b0865"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
	</script> 
	
	<script>
	
	$('#myCarousel').carousel({
		  interval: false
		});
		$('#carousel-thumbs').carousel({
		  interval: false
		});

		// handles the carousel thumbnails
		// https://stackoverflow.com/questions/25752187/bootstrap-carousel-with-thumbnails-multiple-carousel
		$('[id^=carousel-selector-]').click(function() {
		  var id_selector = $(this).attr('id');
		  var id = parseInt( id_selector.substr(id_selector.lastIndexOf('-') + 1) );
		  $('#myCarousel').carousel(id);
		});
		// Only display 3 items in nav on mobile.
		if ($(window).width() < 575) {
		  $('#carousel-thumbs .row div:nth-child(4)').each(function() {
		    var rowBoundary = $(this);
		    $('<div class="row mx-0">').insertAfter(rowBoundary.parent()).append(rowBoundary.nextAll().addBack());
		  });
		  $('#carousel-thumbs .carousel-item .row:nth-child(even)').each(function() {
		    var boundary = $(this);
		    $('<div class="carousel-item">').insertAfter(boundary.parent()).append(boundary.nextAll().addBack());
		  });
		}
		// Hide slide arrows if too few items.
		if ($('#carousel-thumbs .carousel-item').length < 2) {
		  $('#carousel-thumbs [class^=carousel-control-]').remove();
		  $('.machine-carousel-container #carousel-thumbs').css('padding','0 5px');
		}
		// when the carousel slides, auto update
		$('#myCarousel').on('slide.bs.carousel', function(e) {
		  var id = parseInt( $(e.relatedTarget).attr('data-slide-number') );
		  $('[id^=carousel-selector-]').removeClass('selected');
		  $('[id=carousel-selector-'+id+']').addClass('selected');
		});
		// when user swipes, go next or previous
		$('#myCarousel').swipe({
		  fallbackToMouseEvents: true,
		  swipeLeft: function(e) {
		    $('#myCarousel').carousel('next');
		  },
		  swipeRight: function(e) {
		    $('#myCarousel').carousel('prev');
		  },
		  allowPageScroll: 'vertical',
		  preventDefaultEvents: false,
		  threshold: 75
		});
		/*
		$(document).on('click', '[data-toggle="lightbox"]', function(event) {
		  event.preventDefault();
		  $(this).ekkoLightbox();
		});
		*/

		$('#myCarousel .carousel-item img').on('click', function(e) {
		  var src = $(e.target).attr('data-remote');
		  if (src) $(this).ekkoLightbox();
		});
	</script>
	
<%@ include file="../include/footer.jsp" %>
</body>
</html>