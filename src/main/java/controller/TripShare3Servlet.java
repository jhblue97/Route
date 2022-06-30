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

import org.json.simple.JSONObject;

import main.java.dao.TripDAO;
import main.java.dao.TripShareDAO;
import main.java.dto.TripShare;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/tripshare3/*")
public class TripShare3Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private TripDAO tdao;
	private TripShare tripshare;
	private TripShareDAO tsdao;
	private String url;
	private boolean result;
	private JSONObject data;
	//private TripShareDAO 
	
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
		tsdao = new TripShareDAO();
		TripShareDAO ts = new TripShareDAO();
		switch (cmd.split("/")[2]) {	
		case "tripshare.do" : 
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			System.out.println("test ::: "+ ts.getAllTripShare().size());
			request.setAttribute("tripList", ts.getAllTripShare());
	
			RequestDispatcher dispatch = request.getRequestDispatcher("/tripList.jsp");
			dispatch.forward(request, response);	
			return;	
		case "myTripshare.do" :
			session = request.getSession();
			String userId = (String) session.getAttribute("userId");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			System.out.println("test ::: "+ ts.myTripShare(userId).size());
			request.setAttribute("tripList", ts.myTripShare(userId));
	
			RequestDispatcher dispatch2 = request.getRequestDispatcher("/myTripList.jsp");
			dispatch2.forward(request, response);	
		}
		}
	
	
	protected void addTripShare(HttpServletRequest request) {
		System.out.println("일로오나?ddd");
		result = false;
		tripshare = new TripShare();
		
		

		
		String sex[] = request.getParameterValues("sex");
		String age[] = request.getParameterValues("age");
		String nation[] = request.getParameterValues("nation");
		String style[] = request.getParameterValues("style");
		
		System.out.println("길이 측정 : "+sex.length +" age :  "+age.length +" nation : "+nation.length + "style : "+ style.length);
		System.out.println("sex 값 "+sex[0] + "request.getParameter(\"x3\") : "+request.getParameter("x3"));

		tripshare.setUserId(request.getParameter("userId"));
		tripshare.setCost(Integer.parseInt(request.getParameter("cost")));
		tripshare.setPartcipant(Integer.parseInt(request.getParameter("partcipant")));
		tripshare.setTime(Integer.parseInt(request.getParameter("time")));
		tripshare.setSex(String.join(",", sex));
		tripshare.setAge(String.join(",", age));
		tripshare.setNation(String.join(",", nation));
		tripshare.setStyle(String.join(",", style));
		
		tripshare.setX1(Float.parseFloat(request.getParameter("x1")=="" ? "0" : request.getParameter("x1")));
		tripshare.setX2(Float.parseFloat(request.getParameter("x2")=="" ? "0" : request.getParameter("x2")));
		tripshare.setX3(Float.parseFloat(request.getParameter("x3")=="" ? "0" : request.getParameter("x3")));
		tripshare.setY1(Float.parseFloat(request.getParameter("y1")=="" ? "0" : request.getParameter("y1")));
		tripshare.setY2(Float.parseFloat(request.getParameter("y2")=="" ? "0" : request.getParameter("y2")));
		tripshare.setY3(Float.parseFloat(request.getParameter("y3")=="" ? "0" : request.getParameter("y3")));
		tripshare.setTitle1(request.getParameter("title1"));
		tripshare.setTitle2(request.getParameter("title2"));
		tripshare.setTitle3(request.getParameter("title3"));
		tripshare.setTheme(request.getParameter("theme"));
		
		System.out.println(tripshare.toString());
		

		result = 	tsdao.addTripShare(tripshare);
		
		System.out.println("result :: "+result);
		
	}

}
