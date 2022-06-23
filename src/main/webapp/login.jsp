<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<style>
 
.login {
  min-height: 75vh;
} 

.bg-image {
  background-image: url('/resources/images/route_main.png');
  background-size: cover;
  background-position: center;
}

.login-heading {
  font-weight: 300;
}

.btn-login {
  font-size: 0.9rem;
  letter-spacing: 0.05rem;
  padding: 0.75rem 1rem; 
}

</style>

</head>
<body>
<%@ include file="../include/header.jsp" %>
<%@ page import="main.java.dao.UserDAO"%>  
<%@ page import="main.java.dto.Users"%>
  <div class="row g-0">
    <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image"></div>
    <div class="col-md-8 col-lg-6">
      <div class="login d-flex align-items-center py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-9 col-lg-8 mx-auto">
              <h3 class="login-heading mb-4">Login</h3>

              <!-- Sign In Form -->
              <form action="/user/loginProc.do" method="post" accept-charset="UTF-8">
                <div class="form-floating mb-3">
                  <input type="text" class="form-control" id="userId" name = "userId" value = "test" >
                  <label for="floatingInput">id</label>
                </div>
                <div class="form-floating mb-3">
                  <input type="password" class="form-control" id="pwd" name = "pwd" value = "1234" >
                  <label for="floatingPassword">Password</label>
                </div>

                <div class="d-grid">
                  <button class="btn btn-lg btn-primary btn-login text-uppercase fw-bold mb-2" type="submit">로그인</button>
                </div>

              </form>
            </div>
          </div>
        </div> 
      </div>
    </div>
  </div>

 
<%@ include file="../include/footer.jsp" %>
</body>
</html>