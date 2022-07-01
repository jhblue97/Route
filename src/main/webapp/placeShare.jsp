<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행지 공유</title>


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
    	  $('#btn_addProc').hide();
    	  $('#btn_add').show();
    	
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

	  <table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">분류</th>
      <th scope="col">값</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>테마</td>
      <td id = "theme"></td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>비용</td>
        <td id = "cost"> </td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td>관광소요시간</td>
      <td id ="time"> </td>
    </tr>
    <tr>
      <th scope="row">4</th>
      <td>별점</td>
      <td id = "star"> </td>
    </tr>
  </tbody>
</table> 
<input type = "hidden" id = "theme_flag">
<input type = "hidden" id = "La">
<input type = "hidden" id = "Ma">
<input type = "hidden" id = "title">
<input type = "hidden" id = "userId" value = "<%=session.getAttribute("userId")%>">
   <!-- <button type="submit" class="btn btn-info"  data-dismiss="modal"  id="btn_add">후기 등록하기</button> -->
   	 	<button type="button" class="btn btn-info"    id="btn_add">후기 등록하기</button>
   		<button type="button" class="btn btn-info"    id="btn_addProc">등록</button>
    </div>
  </div></div>
  
  <script>
  $('#btn_addProc').hide();
  $('#btn_add').click( function() {
	
	if($('#theme_flag').val() =='false' || $('#theme_flag').val() =='' ){
	console.log('fffflase');
	
		  var select = '<select class="custom-select" id="in_theme">'
			   + ' <option value="food" selected >맛집</option>'
			    + '<option value="place">명소</option>'
			    + '<option value="cafe">카페</option>'
			   + '</select>';
		  $('#theme').html(select);

		  $("#in_theme").prop('disabled',false);
		  
	}else{
		
		var select = '<select class="custom-select" id="in_theme">'
			   + ' <option value="food" >맛집</option>'
			    + '<option value="place">명소</option>'
			    + '<option value="cafe">카페</option>'
			   + '</select>';
		  $('#theme').html(select);
		   
		  $("#in_theme").val($('#theme_flag').val()).prop("selected", true);
		  
		  $("#in_theme").prop('disabled',true);

	}

	  $('#btn_addProc').show();
	  $('#btn_add').hide();
	  

	  
	  
	  
	  $('#cost').html('<input type = "text" id="in_cost" placeholder="원 단위">');
	  $('#time').html('<input type = "text" id="in_time">');
	  $('#star').html('<input type = "text" id="in_star" placeholder="1~5점 사이">');
	
	} );
  
  $('#btn_addProc').click( function() {
	  
 	 $.ajax({   
		   url: '/review/addReview.do', // 요청 할 주소    
		    async: true, // false 일 경우 동기 요청으로 변경    
		    type: 'POST',
		    data: {        
			   theme :  $('#in_theme').val(),      
			   cost :  $('#in_cost').val(), 
			   time:  $('#in_time').val(),    
			   star:  $('#in_star').val(),
			   La : $('#La').val(),
			   Ma : $('#Ma').val(),	   
			   title: $('#title').val(),
			   userId : $('#userId').val()
			  }, // 전송할 데이터   
		    dataType: 'text', // xml, json, script, html   
		    success: function(data) {
		    	console.log(data);
		    	if(data=='true'){
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
		  
	} );
  </script>
	
<%@ include file="../include/footer.jsp" %>
</body>
</html>