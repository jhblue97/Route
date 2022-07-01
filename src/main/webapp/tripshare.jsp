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
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>

</head>

<%@ include file="../include/header.jsp" %>


<%@ page import="main.java.dao.UserDAO"%>  
<%@ page import="main.java.dto.Users"%>  

<body>

   		<button type="button" class="btn btn-info"    id="btn_tripshare">여행 공유</button>
   		
   		
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=402685406ebee4655fe582f2104b0865&libraries=services"></script>
<script>

let tripshare_markers = [];
let index = 1;
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;
        
        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}


// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
	
	 //Ma : 37.5308984676653, 
	 //La : 126.99098869718799
	 
	 //126.99195547652874
     // 37.53588557810444 
	//	126.99094910461599
	//  37.53085611757179

	var position = marker.getPosition(); 
	console.log(position); //
	console.log(position.La); // 위도
	console.log(position.Ma); // 경도

	var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker); 
    
    kakao.maps.event.addListener(marker, 'click', function() {
    	
    	$('#La').val(position.La);
    	$('#Ma').val(position.Ma);
    	$('#title').val(title);
    	$("#myModalLabel" ).text(title +"위도 : "+position.La +"경도 : " + position.Ma);   	
    	
    	  $.ajax({   
    		   url: '/trip/getTrip.do?x='+position.La+"&y="+position.Ma, // 요청 할 주소    
    		    async: true, // false 일 경우 동기 요청으로 변경    
    		    type: 'get',
    		    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		    dataType: 'text', // xml, json, script, html   
    		    success: function(data) {
    		    	console.log(data);
    		    	var json_p = JSON.parse(data);
    		    	console.log(json_p.cost);
    		    	
    				   var theme2 = "";
    				   if(json_p.theme=='place'){
    					   theme2 = '명소'; 
    				   }else if(json_p.theme == 'food'){
    					   theme2 = '맛집';
    				   }else if(json_p.theme == 'cafe'){
    					   theme2 = '카페';
    				   }else{
    					   
    				   }
    					   $('#theme').text(theme2);
    	    		    	   
    					   
    		    	$('#cost').text(json_p.cost);
    		    	$('#time').text(json_p.time);
    		    	$('#star').text(json_p.star);	
    		    	
    		    	if(json_p.theme!=''){
    		    		$('#theme_flag').val(json_p.theme);
    		    	}else{
    		    		$('#theme_flag').val("false");
    		    	}
    		    	
    		    }, // 요청 완료 시   
    		    error: function(data) {
    				
    		   } // 요청 실패.   
    	}); 
    	
    	
    	
    	
    	$('#myModal').modal('show');
    	
  });
    
    
/*     kakao.maps.event.addListener(marker, 'click', function() {
    	
    	  $( function() {
    		     if ($("#dialog").hasClass('ui-dialog-content')) {
    		    	    // do whatever
    		    	 if($("#dialog").dialog("isOpen")==true){
    		    		
    		    			 $("#dialog").empty().dialog('destroy');
    		    			 $( "#dialog" ).attr("title", title +"위도 : "+position.La +"경도 : " + position.Ma);   		    		
         		    		 $( "#dialog" ).dialog( "open" );
    		    	   } 
    		    	}else{
    		    	    // it is not initialized yet
    		    	    $( "#dialog" ).attr("title", title +"위도 : "+position.La +"경도 : " + position.Ma);
    		    	    $( "#dialog" ).dialog();
    		    	}
        } );
    });  */

}



 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}


 
</script>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
        <h4 class="modal-title" id="myModalLabel">write</h4>
      </div>

<input type = "hidden" id = "theme_flag">
<input type = "hidden" id = "La">
<input type = "hidden" id = "Ma">
<input type = "hidden" id = "title">
<input type = "hidden" id = "userId" value = "<%=session.getAttribute("userId")%>">
   <!-- <button type="submit" class="btn btn-info"  data-dismiss="modal"  id="btn_add">후기 등록하기</button> -->
   		<button type="button" class="btn btn-info"    id="btn_addProc">경로 등록</button>
    </div>
  </div></div>
  
  
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
        <h4 class="modal-title" id="myModalLabel">여행 등록</h4>
      </div>
		여행 이름 <input type= "text" id = "theme">
		여행 비용 <input type ="text" id = "cost">
		여행 시간 <input type="text" id="time">
		인원수 <input type="text" id="partcipant">
		여행날짜<input type="date" name="tripdate" id="tripdate" class="form-control" required>
		
				
		<input type= "hidden" id = "x1">
		<input type= "hidden" id = "x2">
		<input type= "hidden" id = "x3">
		
		<input type= "hidden" id = "y1">
		<input type= "hidden" id = "y2">
		<input type= "hidden" id = "y3">
		
		<input type= "hidden" id = "title1">
		<input type= "hidden" id = "title2">
		<input type= "hidden" id = "title3">
		
		<div class="modal-header">
		<h3  class="modal-title" id="myModalLabel"> 조건 </h3>
		</div>
		<div>
		성별 <input type="checkbox" name="sex" value="male">남 
				<input type="checkbox" name="sex" value="female">여
		</div>
		<div>
		나이대 <input type="checkbox" name="age" value="10">10대 
		<input type="checkbox" name="age" value="20">20대 
		<input type="checkbox" name="age" value="30">30대 
		<input type="checkbox" name="age" value="40">40대 
		<input type="checkbox" name="age" value="50">50대 이상
		</div>
		<div>
		국적 <input type="checkbox" name="nation" value="local">내국인 
			<input type="checkbox" name="nation" value="foreign">외국인 
		</div>
		<div>
		여행스타일 <input type="checkbox" name="style" value="photo">사진을 많이 찍어요!
			<input type="checkbox" name="style" value="food">맛집을 많이 가요! 
			<input type="checkbox" name="style" value="sights">명소를 많이 가요!  
 		</div>
 	<button type="button" class="btn btn-info"    id="btn_add_tripshare">등록</button>
    </div>
  </div></div>
  
  
  <script>
  
  
  $('#btn_tripshare').click( function() {
	
	  $('#myModal1').modal('show');
	 	tripshare_markers.forEach((value, index) => {
	 		var la = tripshare_markers[index].La;
	 		var ma = tripshare_markers[index].Ma;
	 		var title = tripshare_markers[index].title;
	 		
	 		
	 		console.log('value : '+value +'index : '+index);
	 		//console.log(tripshare_markers[index].title + ' : '+ tripshare_markers[index].La + ': '+ tripshare_markers[index].Ma);
	 		console.log(title + ' : '+ la + ': '+ ma);
	 		
			++index;
			
	 		$('#x'+(index)).val(la);
	 		$('#y'+(index)).val(ma);
	 		$('#title'+(index)).val(title);
	 		
	 		});
	 	
	 	
	 	/*var i = (++index);
 		
 		$('#x'+(i)).val(tripshare_markers[index].La);
 		$('#y'+(i)).val(tripshare_markers[index].La);
 		$('#title'+(i)).val(tripshare_markers[index].La);
 		
 		var ii = (++i);
 		
 		$('#x'+(ii)).val(tripshare_markers[index].La);
 		$('#y'+(ii)).val(tripshare_markers[index].La);
 		$('#title'+(ii)).val(tripshare_markers[index].La);
 		
 		var iii = (++ii);
 		
 		$('#x'+(iii)).val(tripshare_markers[index].La);
 		$('#y'+(iii)).val(tripshare_markers[index].La);
 		$('#title'+(iii)).val(tripshare_markers[index].La);*/
	 	
  });
  
  
  $('#btn_addProc').click( function() {
	 
	  var La = $('#La').val();
	  var Ma = $('#Ma').val();
	  var title = $('#title').val();
	  
	  

	  var imageSrc = '/resources/images/marker' + index + '.png', // 마커이미지의 주소입니다    
	      imageSize = new kakao.maps.Size(30, 35), // 마커이미지의 크기입니다
	      imageOption = {offset: new kakao.maps.Point(14, 38)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	        
	  // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	      markerPosition = new kakao.maps.LatLng(Ma,La); // 마커가 표시될 위치입니다

	  // 마커를 생성합니다
	  var marker = new kakao.maps.Marker({
	      position: markerPosition, 
	      image: markerImage // 마커이미지 설정 
	  });
	     
	  var positions =	{
			  title: title, 
		        La: La,
		        Ma : Ma
		    };

	  tripshare_markers.push(positions);
	  // 마커가 지도 위에 표시되도록 설정합니다
	  marker.setMap(map);  
	  index++;
	  if(index == 4){
		  index = 1;
	  }
	  
	  
 	/* var positions = [
		
		    {
		        title: title, 
		        latlng: new kakao.maps.LatLng(Ma,La)
		    }
		];
	  
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
	 	
	 	tripshare_markers = tripshare_markers +  positions;
	 	
	 	*/
	 	
	 	
	 	$('#myModal').modal('hide');
  });
  $('#btn_add_tripshare').click( function() {
	  var sexList = [];
	  var ageList = [];
	  var nationList = [];
	  var styleList = [];
	//check한 리스트만 받을수 있게  list 생성하고 하나씩 넣음.
	  $("input[name='sex']:checked").each(function(i){
	  	sexList.push($(this).val());
	  });
	  $("input[name='age']:checked").each(function(i){
	  	ageList.push($(this).val());
	  });
	  $("input[name='nation']:checked").each(function(i){
	  	nationList.push($(this).val());
	  });
	  $("input[name='style']:checked").each(function(i){
	  	styleList.push($(this).val());
	  });
	  
	  console.log('styleList : '+styleList);
		//tripShare2Servlet으로 보낼 생각 하고 있엇어요  
	 	 $.ajax({   
			   url: '/tripshare2/addTripshare.do', // 요청 할 주소    
			    async: true, // false 일 경우 동기 요청으로 변경  
			    traditional: true,  
			    type: 'POST',
			    data: {        
				   cost :  $('#cost').val(), 
				   time:  $('#time').val(),    	 
				   partcipant : $('#partcipant').val(),
			  
				   userId : $('#userId').val(),
				   sex : sexList,
				   age : ageList,
				   nation : nationList,
				   style : styleList,
				   
				   x1 : $('#x1').val(), 
				   x2 : $('#x2').val(), 
				   x3 : $('#x3').val(), 
				   
				   y1 : $('#y1').val(), 
				   y2 : $('#y2').val(), 
				   y3 : $('#y3').val(), 
				   
				   title1 : $('#title1').val(), 
				   title2 : $('#title2').val(), 
				   title3 : $('#title3').val(), 
				   
				   theme : $('#theme').val(),
				   tripdate : $('#tripdate').val()

				  }, // 전송할 데이터   
			    dataType: 'json', // xml, json, script, html   
			    success: function(data) {
			    	console.log(data);
			    	if(data=='true' || data ==true){
			    		alert('등록되었습니다.');
			    		$('#myModal').modal('hide');
			    	}else{
			    		alert('실패했습니다.');
			    		$('#myModal').modal('hide');
			    		
			    	}
			    }, // 요청 완료 시   
			    error: function(data) {
					alert('실패했습니다.');
		    		$('#myModal').modal('hide');
			   } // 요청 실패.   
		}); 
			  
		});
  </script>
	
<%@ include file="../include/footer.jsp" %>
</body>
</html>