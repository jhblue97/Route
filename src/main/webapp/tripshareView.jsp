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


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=402685406ebee4655fe582f2104b0865&libraries=services"></script>




<div class="jumbotron">
	<div class="container">
		<h1 class="display-5">경로 여행 상세  조회</h1>
	</div> 
</div>
<form action="/participant/addParticipant.do"
		  class="form-horizontal" method="post"  id="addMemberFrm" accept-charset="UTF-8">

 <%
  String session_userId = session.getAttribute("userId")+"";
 pageContext.setAttribute("session_userId", session_userId);
 %>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10"> 
			<input type="button" class="btn btn-secondary" value="돌아가기" onclick="history.back()">
			<input type="submit" class="btn btn-info" value="참여하기">  	
			<c:if test="${tripsharevo.userId == session_userId}">
				<input type="button" class="btn btn-danger" id = "delete" value="삭제"> 	
			  </c:if>
				</div></div>	
				
				
<input type = "hidden"  name = "partuserId" id = "partuserId" value = "<%=session.getAttribute("userId")%>">
	<input type="hidden" name="tripshareNo" id="tripshareNo" value = "${tripsharevo.tripshareNo}" readonly>
	
		<div class="form-group row">
			<label class="col-sm-2">여행등록자</label>
			<div class="col-sm-3">
				<input type="text" name="userId" id="userId" value = "${tripsharevo.userId}" readonly>
			</div>
		</div>	   
	 
		<div class="form-group row">
			<label class="col-sm-2">여행 경로이름</label>
			<div class="col-sm-3">
				<input type="text" name="theme" id="theme" value =" ${tripsharevo.theme}" readonly>
			</div>
		</div>	   

	 	<div class="form-group row">
			<label class="col-sm-2">여행 비용</label>
			<div class="col-sm-3">
				<input type="text" name="cost" id="cost" value ="${tripsharevo.cost}" readonly>
			</div>
		</div>	   
	 
	   	<div class="form-group row">
			<label class="col-sm-2">여행 날짜</label>
			<div class="col-sm-3">
				<input type="text" name="tripdate" id="tripdate" value ="${tripsharevo.tripdate}" readonly>
			</div>
		</div>	   
	 
	 	   	<div class="form-group row">
			<label class="col-sm-2">참가인원</label>
			<div class="col-sm-3">
				<input type="text" name="participant" id="participant" value ="${tripsharevo.partcipant} / ${tripsharevo.totalPartcipant}" readonly>
			</div>
		</div>	 
		
		 <c:set var="total" value = ""/>
			<c:set var="tel" value="${fn:split(tripsharevo.style,',')}" />
			<c:forEach var="telNum" items="${tel}" varStatus="g">   
  				 <c:if test="${telNum eq 'photo'}">   <c:set var="total" value="${total +=  '사진을 많이 찍어요!   '  }"/>   </c:if>      
 				 <c:if test="${telNum eq 'food'}">   <c:set var="total" value="${total +=   '맛집을 많이 가요!   '  }"/>    </c:if>    
 				 <c:if test="${telNum eq 'sights'}">  <c:set var="total" value="${total +=   '명소를 많이가요!   '  }"/>  </c:if>        			
 				<%-- <c:if test="${g.last}">-${telNum}</c:if> --%> 
 			</c:forEach> 
			<div class="form-group row">
			<label class="col-sm-2">스타일 </label>
			<div class="col-sm-3">
				<textarea rows="5" cols="50" name="style" id="style" class="form-control" readonly>${total}</textarea>
			
			</div>
		</div>	
		
			<div class="form-group row">
			<label class="col-sm-2">국적 </label>
			<div class="col-sm-3">				
				<input type="text" name="nation" id="nation" value ="${tripsharevo.nation}" readonly>
			</div>
		</div>	
		
			<div class="form-group row">
			<label class="col-sm-2">나이 </label>
			<div class="col-sm-3">
				<input type="text" name="age" id="age" value ="${tripsharevo.age}" readonly>
			</div>
		</div>	
		
		  <div class="form-group row">
			<label class="col-sm-2">성별 </label>
			<div class="col-sm-3">
				<input type="text" name="sex" id="sex" value ="${tripsharevo.sex}" readonly>
			</div>
		</div>	
	<div id="map" style="width:100%;height:350px;"></div>
	
	
<%-- 	<iframe src="https://map.kakao.com/?sName=${tripsharevo.title1}&eName=${tripsharevo.title2}" style="width:100%; height:300px"></iframe>
 --%>	
					
	 </form>
	 

  
  
<script>

$('#delete').on('click',function(){ 
	
	location.href = '/deleteTripshareViewProc.jsp?tripshareno='+$('#tripshareNo').val();
	
});


let index = 1;
var x1 = ${tripsharevo.x1};
var x2 = ${tripsharevo.x2};
var x3 = ${tripsharevo.x3};

var y1 = ${tripsharevo.y1};
var y2 = ${tripsharevo.y2};
var y3 = ${tripsharevo.y3};

var title1 = '${tripsharevo.title1}';
var title2 = '${tripsharevo.title2}';
var title3 = '${tripsharevo.title3}'; 



var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(y1, x1), // 지도의 중심좌표
        level: 3// 지도의 확대 레벨
       
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 
var positions = [
    {
    	content: title1, 
        latlng: new kakao.maps.LatLng(y1, x1)
    } ,{
    	content: title2, 
	        latlng: new kakao.maps.LatLng(y2,x2)
	    }   	
	    	,{
	    		content:title3, 
		        latlng: new kakao.maps.LatLng(y3,x3)
		    }
];



for (var i = 0; i < positions.length; i ++) {
    
	var imageSrc = '/resources/images/marker' + index + '.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(30, 35), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(14, 38)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);  

    
	  var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커의 위치
	        image: markerImage // 마커이미지 설정 
	    });

	  index++;
	  if(index == 4){
		  index = 1;
	  }
	  
	  // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: positions[i].content // 인포윈도우에 표시할 내용
	    });
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	  
}

//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

</script>


	
<%@ include file="../include/footer.jsp" %>
</body>
</html>