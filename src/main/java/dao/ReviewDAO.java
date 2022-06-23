package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import main.java.dto.Review;
import main.java.dto.Trip;
import main.java.dto.Users;
import main.java.util.DBcon;






public class ReviewDAO {

	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String query;
	private boolean result;
	


	  
	
  public boolean addReview(Review review) {
		  
	
	  
		  query =
				  "INSERT INTO DEV.REVIEW"
				  +"(REVIEWNO, TRIPNO, USERID, STAR, COST, TIME,REGDATE)"
				  +"VALUES(REVIEWNO_SEQ.NEXTVAL, ?, ?, ?, ?, ?,SYSDATE)";


		  System.out.println(query);
		  
		  try { 
		  con = DBcon.getConnection(); 
		  pstmt = con.prepareStatement(query);
		  pstmt.setInt(1,review.getTripNo());
		  pstmt.setString(2,review.getUserId());
		  pstmt.setFloat(3,review.getStar());
		  pstmt.setFloat(4, review.getCost());
		  pstmt.setFloat(5, review.getTime());
		//  pstmt.setString(1,trview.getPlace()); 
	
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





private PreparedStatement setInt(int i, int tripNo) {
	// TODO Auto-generated method stub
	return null;
}
  

	}
