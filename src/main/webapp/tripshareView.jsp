<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


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
<style>

</style>

</head>

<%@ include file="../include/header.jsp" %>


<%@ page import="main.java.dao.UserDAO"%>  
<%@ page import="main.java.dto.Users"%>  

<body>

<button type="button" class="btn btn-info"    id="btn_tripshare">참가하기</button>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=402685406ebee4655fe582f2104b0865&libraries=services"></script>

<div class="jumbotron">
	<div class="container">
		<h1 class="display-5">경로 여행 상세  조회</h1>
	</div>
</div>


  
  
  
  
	
<%@ include file="../include/footer.jsp" %>
</body>
</html>