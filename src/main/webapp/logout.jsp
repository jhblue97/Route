<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%



	session.invalidate();
	response.sendRedirect("/test");


//세션 무효화 및 메인 페이지로 이동
%>