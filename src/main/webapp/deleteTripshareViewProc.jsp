<%@page import="main.java.dao.TripShareDAO"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<%@ include file="../include/header.jsp" %>   

    <%
    

	request.setCharacterEncoding("UTF-8");
	String tripshareno = request.getParameter("tripshareno");   
    TripShareDAO tdao = new TripShareDAO(); 
    boolean result = tdao.deleteTripShare(tripshareno);
    %>
     
<%if(result){ %>
<script>
	location.href = "/tripshare3/tripshare.do";

</script>
<%}else{ %>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-5">삭제 실패</h1>
	</div>
</div>
<%}%>