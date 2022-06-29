<%@page import="main.java.dao.UserDAO"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<%@ include file="../include/header.jsp" %>   

    <%
    

	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
    session.invalidate(); 
    
    UserDAO udao = new UserDAO(); 
    boolean result = udao.deleteUser(userId);

    %>
     
<%if(result){ %>
<script>
	location.href = "/index.jsp";

</script>
<%}else{ %>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-5">탈퇴  실패</h1>
	</div>
</div>
<%}%>