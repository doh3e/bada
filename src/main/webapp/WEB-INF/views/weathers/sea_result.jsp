<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/sea_result.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/slide.css" rel="stylesheet" type="text/css">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>

<div class="sea_result_main">

<div class="sea_result_left">
	<div class="sea_result_left_top">
	<div class="info_box">
	<span id="beach_name">${bdt.beach_name}</span>
	<br><br><hr><br><br>
		
		<div class="info_slider" width="300px" height="300px">
			<div class="slide slide_wrap">
			  <div class="slide_item item1">
			  <img src="./resources/image/${bdt.picture1}"></div>
			  <div class="slide_item item2">
			  <img src="./resources/image/${bdt.picture2}"></div>
			  <div class="slide_item item3">
			  <img src="./resources/image/${bdt.picture3}"></div>
			  <div class="slide_prev_button slide_button">＜</div>
			  <div class="slide_next_button slide_button">＞</div>
			  <ul class="slide_pagination"></ul>
			</div>
		</div>
		
		<div class="info_text">
		<h3>바다 소개</h3>
		<br><hr><br>
		${bdt.infomation}
		</div>
	
	</div>
	</div>
	
	<div class="sea_result_left_bottom">
	<div class="info_box inbottom">
		<div id="map" style="width:280px;height:280px;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=513793c3569011c75762309c9b3a2138"></script>
			<script>
			
		    var latitude = "${latitude}";
		    var longitude = "${longitude}";
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			        level: 4 // 지도의 확대 레벨
			    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			var iwContent = '<div class="inmaptext">${bdt.beach_name}<br><br><a href="https://map.kakao.com/link/map/${bdt.beach_name},${latitude},${longitude}" style="color:blue" target="_blank">자세히보기</a> <a href="https://map.kakao.com/link/to/${bdt.beach_name},${latitude},${longitude}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new kakao.maps.LatLng(latitude, longitude); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
			</script>
			
			<div class="info_text">
			<h3>바다 안내</h3>
			<br><hr><br>
			주소 : ${bdt.address}<br>
			편의시설 : ${bdt.accomodation}<br>
			특징 : ${bdt.special}<br><br>
			<h4>많이 달린 해시태그</h4><br>
			</div>
		</div>
	</div>
</div>

<div class="sea_result_right">

<div class="weatherbox">
<span id="beach_name">날씨 정보 요약</span>
<br><br><hr><br><br>
<div><a href="sea_weather_detail?beachName=${bdt.beach_name}">날씨 자세히 보기</a></div>
<div id="weather-info">
<script type="text/javascript">
	var beachName = "${bdt.beach_name}";
</script>
</div>
</div>

</div>

</div>

<script src="./resources/js/slide.js"></script>
<script type="text/javascript">
//Date 함수
var currentDate = new Date();
// 날짜 변수
var year = currentDate.getFullYear();
var month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 문자열의 최종 길이를 2로 설정. 문자열의 길이가 그보다 짧으면 앞에 0을 붙이기
var day = currentDate.getDate().toString().padStart(2, '0');
var dateString = year+ month + day;

var yesterday = year + month + (currentDate.getDate() - 1).toString().padStart(2, '0');

// 시간 변수 -> 얘네는 기본으로 2자리로 설정
var hours = currentDate.getHours();
var minutes = currentDate.getMinutes();

// 초단기 예보 basetime에 맞게 설정
function setToThirtyMinutes(){
	if (minutes > 30){
		return hours + '30';
	}
	else{
		return (hours - 1) + '30';
	}
}

// 초단기 예보 fcsttime에 맞게 설정
function setToTopOfHour(){
	if (minutes > 30){
		return (hours + 1) + '00';
	}else{
		return hours + '00'
	}
}

document.addEventListener("DOMContentLoaded", function() {
    fetchWeather(beachName);
});

function fetchWeather() {
	fetch("weather_beachName?beachName=" + beachName)
	.then(response => {
		if (!response.ok) {
            throw new Error("fetchWeather 실패");
        }
		return response.json();
	})
	.then(data => {
		return getUltraSrtFcstBeach(data.beach_code)
	})
	.catch(error => {
        console.error("Error fetching weather data:", error);
    });
}

function getUltraSrtFcstBeach(beachnum) {
	// API 호출
    var url = 'http://apis.data.go.kr/1360000/BeachInfoservice/getUltraSrtFcstBeach'; /*URL*/
    var serviceKey = 'QWzzzAb%2FUIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J%2BlicoY1Dffo51%2Fi5HTDfU00ZpDy2E4%2FASt2FgLknaA%3D%3D'; /*Service Key*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + serviceKey;
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('54');
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
    queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON');
    queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(dateString);
    queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent(setToThirtyMinutes());
    queryParams += '&' + encodeURIComponent('beach_num') + '=' + beachnum;
  	console.log(url + queryParams);
    return fetch(url + queryParams)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
       console.log(JSON.stringify(data.response.body.items.item));
       
    })
    .catch(error => {
        console.error('Fetch Error', error);
        throw error; // 에러를 상위로 전파
    });
}

</script>

</body>
</html>