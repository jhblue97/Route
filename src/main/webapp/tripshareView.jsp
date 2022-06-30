<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<%

response.setCharacterEncoding("UTF-8"); 
response.setContentType("text/html; charset=UTF-8"); 
request.setCharacterEncoding("UTF-8"); 
System.out.println("no :: "+request.getParameter("tripshareNo"));
%>

<body>

<button type="button" class="btn btn-info"    id="btn_tripshare">참가하기</button>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=402685406ebee4655fe582f2104b0865&libraries=services"></script>




<div class="jumbotron">
	<div class="container">
		<h1 class="display-5">경로 여행 상세  조회</h1>
	</div>
</div>
<input type = "hidden" id = "userId" value = "<%=session.getAttribute("userId")%>">
<form action="/participant/addParticipant.do"
		  class="form-horizontal" method="post"  id="addMemberFrm" accept-charset="UTF-8">

		<div class="form-group row">
			<label class="col-sm-2">여행등록자</label>
			<div class="col-sm-3">
				<input type="text" name="userid" id="userid" value = "" readonly>
			</div>
		</div>	   
	 
		<div class="form-group row">
			<label class="col-sm-2">여행 테마</label>
			<div class="col-sm-3">
				<input type="text" name="theme" id="theme" value ="" readonly>
			</div>
		</div>	   

	 	<div class="form-group row">
			<label class="col-sm-2">여행 비용</label>
			<div class="col-sm-3">
				<input type="text" name="cost" id="cost" value ="" readonly>
			</div>
		</div>	   
	 
	   	<div class="form-group row">
			<label class="col-sm-2">여행 날짜</label>
			<div class="col-sm-3">
				<input type="text" name="tripdate" id="tripdate" value ="" readonly>
			</div>
		</div>	   
	 
	 	   	<div class="form-group row">
			<label class="col-sm-2">참가인원</label>
			<div class="col-sm-3">
				<input type="text" name="participant" id="participant" value ="" readonly>
			</div>
		</div>	 
		
			<div class="form-group row">
			<label class="col-sm-2">스타일 </label>
			<div class="col-sm-3">
				<input type="text" name="style" id="style" value ="" readonly>
			</div>
		</div>	
		
			<div class="form-group row">
			<label class="col-sm-2">국적 </label>
			<div class="col-sm-3">
				<input type="text" name="nation" id="nation" value ="" readonly>
			</div>
		</div>	
		
			<div class="form-group row">
			<label class="col-sm-2">나이 </label>
			<div class="col-sm-3">
				<input type="text" name="age" id="age" value ="" readonly>
			</div>
		</div>	
		
		  <div class="form-group row">
			<label class="col-sm-2">성별 </label>
			<div class="col-sm-3">
				<input type="text" name="sex" id="sex" value ="" readonly>
			</div>
		</div>	
	<div id="map" style="width:100%;height:350px;"></div>
	
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
			<input type="button" class="btn btn-secondary" value="돌아가기" onclick="history.back()">
			<input type="submit" class="btn btn-info" value="참여하기"> 	
			
				</div></div>						
	 </form>
	 

  
  
<script>



var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 
var positions = [
    {
        title: '카카오', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
    },
    {
        title: '생태연못', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        title: '텃밭', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        title: '근린공원',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
];

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>
  
  
	
<%@ include file="../include/footer.jsp" %>
</body>
</html>