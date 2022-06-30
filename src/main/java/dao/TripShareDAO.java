package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import main.java.dto.Trip;
import main.java.dto.TripShare;
import main.java.dto.Users;
import main.java.util.DBcon;
import main.java.vo.TripVO;






public class TripShareDAO {

	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String query;
	private boolean result;
	


	  
	
  public boolean addTripShare(TripShare trip) {
		  
	
	  
		  query =
				 "  INSERT INTO DEV.TRIPSHARE "
				 + " (TRIPSHARENO, USERID, COST, PARTICIPANT, \"TIME\", SEX, AGE, NATION, \"STYLE\", X1, X2, X3, Y1, Y2, Y3, TITLE1,TITLE2,TITLE3,THEME,TRIPDATE) "
				  + " VALUES(TRIPSHARENO_SEQ.nextval, ?,?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?,?,?,?,?)";


		  System.out.println(query);
		  
		  try { 
		  con = DBcon.getConnection(); 
		  pstmt = con.prepareStatement(query);
		  pstmt.setString(1,trip.getUserId());  
		  pstmt.setInt(2,trip.getCost()); 
		  pstmt.setInt(3,trip.getPartcipant()); 
		  pstmt.setInt(4,trip.getTime()); 
		  pstmt.setString(5,trip.getSex()); 
		  pstmt.setString(6,trip.getAge()); 
		  pstmt.setString(7,trip.getNation()); 
		  pstmt.setString(8,trip.getStyle()); 
		  pstmt.setFloat(9,trip.getX1()); 
		  pstmt.setFloat(10,trip.getX2()); 
		  pstmt.setFloat(11,trip.getX3()); 
		  pstmt.setFloat(12,trip.getY1()); 
		  pstmt.setFloat(13,trip.getY2()); 
		  pstmt.setFloat(14,trip.getY3()); 
		  pstmt.setString(15,trip.getTitle1()); 
		  pstmt.setString(16,trip.getTitle2()); 
		  pstmt.setString(17,trip.getTitle3()); 
		  pstmt.setString(18,trip.getTheme()); 
		  pstmt.setString(19,trip.getTripdate()); 
		  
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
  
  
	}
