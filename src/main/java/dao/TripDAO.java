package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import main.java.dto.Trip;
import main.java.dto.Users;
import main.java.util.DBcon;
import main.java.vo.TripVO;






public class TripDAO {

	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String query;
	private boolean result;
	


	  
	
  public boolean addTrip(Trip trip) {
		  
	
	  
		  query =
				  " INSERT INTO DEV.TRIP "
				 + "(TRIPNO, PLACE, THEME, X, Y, REGDATE)"
				 + " VALUES(TRIPNO_SEQ.nextval, ?, ?, ?, ?, sysdate) ";

		  System.out.println(query);
		  
		  try { 
		  con = DBcon.getConnection(); 
		  pstmt = con.prepareStatement(query);
		  pstmt.setString(1,trip.getPlace()); 
		  pstmt.setString(2,trip.getTheme());  
		  pstmt.setString(3,trip.getX()); 
		  pstmt.setString(4,trip.getY()); 
		  if(pstmt.executeUpdate()==1) { 
			   System.out.println("insert ok"); 
			  result = true;
		  
		  }else { 
			  System.out.println("insert not ok");
		  
		  result = false; 
		  }
		  }catch (SQLException e) { // TODO Auto-generated catch block
		  e.printStackTrace(); } finally { DBcon.close(pstmt);
		  
		  }
		  return result; 
		  }
  
  public Trip getTrip(String x,String y) {
	  
		Trip trip = new Trip();
	  
	  query = "select * from trip where x = "+x+" and y = "+y;
	  System.out.println(query);
	  
		try {		
			con = DBcon.getConnection();
			stmt = con.createStatement();			
			rs = stmt.executeQuery(query); //5 		
			if(rs.next()) {
				trip.setTripNo(rs.getInt("tripno"));
				trip.setPlace(rs.getString("place"));
				trip.setX(rs.getString("x"));
				trip.setY(rs.getString("y"));
				trip.setTheme(rs.getString("theme"));
			}		
		}catch (SQLException e) { // TODO Auto-generated catch block
		e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return trip; 
	  }
  public TripVO getTrip2(String x,String y) {
	  
	  TripVO trip = new TripVO();
	  
	  query = "SELECT MAX(A.TRIPNO) AS TRIPNO, MAX(A.THEME) AS THEME, MAX(A.PLACE) AS PLACE ,AVG(B.TIME) AS TIME , AVG(B.COST) AS COST , AVG(B.STAR) AS star  ,max(a.x) AS x , max(a.y) AS y"
	  		+ " FROM TRIP A LEFT OUTER JOIN REVIEW B ON A.TRIPNO = B.TRIPNO "
	  		+ " WHERE A.X = "+ x +" AND A.Y = "+y;
	  System.out.println(query);
	  
		try {		
			con = DBcon.getConnection();
			stmt = con.createStatement();			
			rs = stmt.executeQuery(query); //5 		
			if(rs.next()) {
				trip.setTripNo(rs.getInt("tripno"));
				trip.setPlace(rs.getString("place"));
				trip.setX(rs.getString("x"));
				trip.setY(rs.getString("y"));
				trip.setTheme(rs.getString("theme"));
				trip.setCost(rs.getFloat("cost"));
				trip.setStar(rs.getFloat("star"));
				trip.setTime(rs.getFloat("time"));
			}		
		}catch (SQLException e) { // TODO Auto-generated catch block
		e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return trip; 
	  }
  
  public int getTripChk(String x,String y) {
	  
		int count = 0;
	  query = "select count(*) as count from trip where x = "+x+" and y = "+y;
	  System.out.println(query);
	  
		try {		
			con = DBcon.getConnection();
			stmt = con.createStatement();			
			rs = stmt.executeQuery(query); //5 		
			if(rs.next()) {
				count = rs.getInt("count");
			}		
		}catch (SQLException e) { // TODO Auto-generated catch block
		e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return count; 
	  }

  public int getTripNo(String x,String y) {
	  
		int tripno = 0;
	  query = "select tripno from trip where x = "+x+" and y = "+y;
	  System.out.println(query);
	  
		try {		
			con = DBcon.getConnection();
			stmt = con.createStatement();			
			rs = stmt.executeQuery(query); //5 		
			if(rs.next()) {
				tripno = rs.getInt("tripno");
			}		
		}catch (SQLException e) { // TODO Auto-generated catch block
		e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return tripno; 
	  }
  
	}
