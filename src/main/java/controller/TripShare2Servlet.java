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
import main.java.dao.UserDAO;
import main.java.dto.Users;
import main.java.vo.TripVO;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/tripshare2/*")
public class TripShare2Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private TripDAO tdao;
	private TripVO tripvo;
	private String url;
	private boolean result;
	private JSONObject data;
	private PrintWriter out;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		}
	
	
	protected void gettrip(HttpServletRequest request) {
		System.out.println("일로오나?");
		tripvo = new TripVO();
		
		tripvo = tdao.getTrip2(request.getParameter("x"), request.getParameter("y"));
		
	    data = new JSONObject();
        data.put("tripNo", tripvo.getTripNo());
        data.put("place", tripvo.getPlace());
        data.put("theme", tripvo.getTheme());
        data.put("star", tripvo.getStar());
        data.put("cost", tripvo.getCost());
        data.put("x", tripvo.getX());
        data.put("y", tripvo.getY());
        data.put("time", tripvo.getTime());
	}

}