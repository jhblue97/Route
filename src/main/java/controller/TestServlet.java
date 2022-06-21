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
@WebServlet("/test")
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private UserDAO udao;
	private Users user;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		udao = new UserDAO();
		user = new Users();
		user = udao.getUser("test", "1234");
		request.setAttribute("user", user);
		System.out.println("user :::: " + user.getUserID());
		RequestDispatcher dispatch = request.getRequestDispatcher("/index.jsp");
		dispatch.forward(request, response);
	}
}
