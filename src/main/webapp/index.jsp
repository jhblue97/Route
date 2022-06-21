
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
<%

	HttpSession session2 = request.getSession();
	UserDAO udao = new UserDAO();

	Users user = new Users();
 
	user = udao.getUser("test","1234");

	System.out.println("user :::: "+user.getUserID());
%>


<%=user.getUserName()%>
Route 

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
<%@ include file="../include/footer.jsp" %>
</body>
</html>