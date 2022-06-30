<%@page import="main.java.dto.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script src="/resources/js/script.js"></script> 

<link rel="stylesheet" 
	  href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
	  
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>	  
<style>
.navbar {
background-color: orangered;
}
</style>

<link rel="stylesheet" href="/resources/css/common.css">


<nav class="navbar navbar-expand-lg navbar-light">
  <a class="navbar-brand" href="/test">Route</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="/test">main <span class="sr-only">(current)</span></a>
      </li>
      <% if(session.getAttribute("userName")!=null){ %>
         <li class="nav-item">
        <a class="nav-link" href="#">여행공유</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/tripshare/tripshare.do">여행경로공유</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/tripshare3/tripshare.do">여행목록</a>
      </li>

      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         <%=session.getAttribute("userName")%>님 어서오세요. 
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href = "/logout.jsp">로그아웃</a>
          <a class="dropdown-item" href="#">회원탈퇴</a>
          <a class="dropdown-item" href="#">내가 참가한 여행 목록</a>
        </div>
      </li>
      
			<%}else{ %>
			      <li class="nav-item">
        <a class="nav-link" href="/user/login.do">로그인</a>
      </li>
      			
      			      <li class="nav-item">
        <a class="nav-link" href="/signIn.jsp">회원가입</a>
      </li>
      			
			<%}%>

    </ul>
  </div>
</nav>

<script>


</script>