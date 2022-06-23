package main.java.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import main.java.dao.UserDAO;
import main.java.dto.Users;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private UserDAO udao;
	private Users user;
	private String url;
	private boolean result;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = requestURI.substring(contextPath.length());
		

		udao = new UserDAO();
		
		switch (cmd.split("/")[2]) {	
		case "login.do" : response.sendRedirect("/login.jsp");	return;	//로그인 테스트 
		case "loginProc.do" : 
        session = request.getSession();		
		getUser(request.getParameter("userId"),request.getParameter("pwd"));
		RequestDispatcher dispatch = request.getRequestDispatcher("/index.jsp");
		session.setAttribute("userId",user.getUserID());
		session.setAttribute("userName",user.getUserName());
		dispatch.forward(request, response);
		return;	 
		case "signIn.do" :  session = request.getSession();	 addUser(request); response.sendRedirect(url);	return;
		default : 
			break;
		}

		
		
	}
	
	protected void addUser(HttpServletRequest request) throws ServletException, IOException {
		
		result = false;
		user = new Users();
		user.setUserID(request.getParameter("userId"));
		user.setUserName(request.getParameter("userName"));
		user.setPwd(request.getParameter("pwd"));
		user.setBirth(request.getParameter("birth"));
		user.setSex(request.getParameter("sex"));
		user.setNation(request.getParameter("nation"));

		result = udao.addUser(user); 
		if(result == true) { 
			session.setAttribute("result","true");  
		} else { //그렇지 않은 경우
			session.setAttribute("result","false");   
		}
		
		url = "/index.jsp";	//url 		
		
	}

	
	protected void getUser(String userId, String pwd) throws ServletException, IOException {
		
		user = new Users();
		user = udao.getUser(userId,pwd);
		System.out.println("user--->"+user.getPwd());

		
	}
	
	protected void login(HttpServletRequest request, HttpServletResponse response) {
		RequestDispatcher dispatch = request.getRequestDispatcher("/index.jsp");
		//dispatch.forward(request, response);
	}
}
