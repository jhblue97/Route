package main.java.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import main.java.dao.ParticipantDAO;
import main.java.dao.TripDAO;
import main.java.dao.TripShareDAO;
import main.java.dao.UserDAO;
import main.java.dto.Participant;
import main.java.dto.Trip;
import main.java.dto.TripShare;
import main.java.dto.Users;
import main.java.vo.TripVO;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/participant/*")
public class ParticipantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private TripDAO tdao;
	private TripShare tripshare;
	private TripShareDAO tsdao;
	private String url;
	private boolean result;
	private JSONObject data;
	private Participant part;
	private ParticipantDAO partdao;
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
		PrintWriter out = response.getWriter();
		partdao = new ParticipantDAO();
		
			switch (cmd.split("/")[2]) {	
			case "addParticipant.do" :  addParticipant(request);  response.sendRedirect("/tripshare3/tripshare.do?result="+result); return;
			}
		}
	
	
	protected void addParticipant(HttpServletRequest request) {
		part = new Participant();
		result = false;
		System.out.println("일로오나?fp");

		
		System.out.println("result :: "+result);
		
		part.setPartuserId(request.getParameter("partuserId"));
		part.setTripshareNo(Integer.parseInt(request.getParameter("tripshareNo")));
		
		result = partdao.addParticipant(part);
		
		
		
	}

}
