<%@page import="java.util.List"%>

<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>



</head>

<body  class="main-bg" style ="   
	height: 100%;margin: 0;
    background-repeat: no-repeat;
    background-attachment: fixed;">

<%@ include file="../include/header.jsp" %>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-5">
			회원가입</h1></div></div>
	<div class="container">
			<form role="form" method="post" action="/user/signIn.do">
				<div class="form-group row ">
					<label class="col-sm-2">아이디</label>
					<div class="col-sm-4">
						<input type="text" name="userId" id="userId" class="form-control"/>
					</div>
				</div>
				
				<div class="form-group row mt-4">
					<label class="col-sm-2">닉네임</label>
					<div class="col-sm-4">
						<input type="text" name="userName" id="userName"
							class="form-control">
					</div>					
				</div>
				<div class="form-group row mt-4">
					<label class="col-sm-2">비밀번호</label>
					<div class="col-sm-4">
						<input type="password" name="pwd" id="pwd"
							class="form-control" required>
					</div>
				</div>
				
				<div class="form-group row mt-4">
					<label class="col-sm-2">비밀번호확인</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="pwd2" required>
					</div>
				</div>
				<div class="form-group row mt-4">
					<label class="col-sm-1 mr-5">생년월일</label>
					<div class="col-sm-3 ">
						<input type="date" name="birth" id="birth" class="form-control" required>
					</div>
				</div>
				
				<div class="form-group row mt-4 ml-3">
					<label class="col-sm-1 mr-3">성별</label>
					<div class="col-sm-5">
						<label><input type="radio" name="sex" value="M" required> 남성</label>
						<label><input type="radio" name="sex" value="F" required> 여성</label>
						
					</div>
				</div>

				<div class="form-group row mt-4 ml-3">
					<label class="col-sm-1 mr-3">국적</label>
					<div class="col-sm-5">
						<label><input type="radio" name="nation" value="KOR" required> 한국</label>
						<label><input type="radio" name="nation" value="JP" required> 일본</label>
						<label><input type="radio" name="nation" value="CNA" required> 중국</label>
						<label><input type="radio" name="nation" value="USA" required> 미국</label>
					</div>
				</div>
				
			<div class="form-group row mt-4 ml-3">
					<div class="col-sm-offset-2 col-sm-12 text-center">
						<input type="button" class="btn btn-secondary"
							style="width: 100px;" value="취소" onclick="history.back()">
						<input type="submit" class="btn offset-2" id="uploadBtn"
							style="width: 100px; background-color: #37867F; color:white; " value="등록">  
					</div>
				</div>
			</form>
			

			
		</div>
				<script>
				
				function check(){
		
					if($('#idCheck3').val()=='N'){
						
						alert("아이디 중복 체크 해주세요.");
						return;
					}
				
					
					if($('#pwd').val()!=$('#pwd2').val()){
						
						alert("비밀번호랑 재 비밀번호랑 다릅니다.");
					return;
					}
					
					$('#addMemberFrm').submit(); 
		
				}
				
				function idCheck(){
					   $.ajax ({

					        "url" : "/idCheck.jsp?id="+$('#userId').val(),
					        cache : false,
					        type:"get", 
					        success : function (data) {
					        	
					         
					        	console.log(data);
					        
					        	if(data==0){
					        		alert('사용 가능합니다.');       		
					        		$('#idCheck3').val('Y');
					        	}else{
					        		alert('이미 존재합니다.');
					        		$('#idCheck3').val('N');
					        	} 
					        }
					    });   
				}		
				</script>

<%@ include file="../include/footer.jsp" %>
</body> 
</html>