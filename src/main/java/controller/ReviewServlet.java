package main.java.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import main.java.dao.ReviewDAO;
import main.java.dao.TripDAO;
import main.java.dao.UserDAO;
import main.java.dto.Review;
import main.java.dto.Trip;
import main.java.dto.Users;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/review/*")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private ReviewDAO rdao;
	private TripDAO tdao;
	private Review review;
	private Trip trip;
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
		PrintWriter out = response.getWriter();

		rdao = new ReviewDAO();
		tdao = new TripDAO();
		switch (cmd.split("/")[2]) {	
		case "addReview.do" :  addReview(request);  out.print(result); return;
		case "test.do" :  test(request); out.print(result); return;
		}
	}
	protected void test(HttpServletRequest request) {
		
	}
	
protected void addReview(HttpServletRequest request) throws ServletException, IOException {
	
		result = false;
		int count = tdao.getTripChk(request.getParameter("La"),request.getParameter("Ma"));
		if(count==0) {
			System.out.println("신규트립작성임 "+request.getParameter("theme"));
		trip = new Trip();
		trip.setPlace(request.getParameter("title"));
		trip.setX(request.getParameter("La"));
		trip.setY(request.getParameter("Ma"));
		trip.setTheme(request.getParameter("theme"));
		
		result = tdao.addTrip(trip);
		
		System.out.println("cost---->"+Float.parseFloat(request.getParameter("cost")));
		int tripno = tdao.getTripNo(request.getParameter("La"),request.getParameter("Ma"));
			if(result==true) {
				
				review = new Review();
				review.setCost(Float.parseFloat(request.getParameter("cost")));
				review.setStar(Float.parseFloat(request.getParameter("star")));
				review.setUserId(request.getParameter("userId"));
				review.setTripNo(tripno);
				review.setTime(Float.parseFloat(request.getParameter("time")));
				result = rdao.addReview(review);

			}else {return;}
		}else {
			int tripno = tdao.getTripNo(request.getParameter("La"),request.getParameter("Ma"));
			
			review = new Review();
			review.setCost(Float.parseFloat(request.getParameter("cost")));
			review.setStar(Float.parseFloat(request.getParameter("star")));
			review.setUserId(request.getParameter("userId"));
			review.setTripNo(tripno);
			review.setTime(Float.parseFloat(request.getParameter("time")));
			
			result = rdao.addReview(review);
			
		}
		
	}

}
