package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import main.java.dto.Participant;
import main.java.dto.TripShare;
import main.java.util.DBcon;
import main.java.vo.TripShareVO;






public class ParticipantDAO {

	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String query;
	private boolean result;
	


	  
	
  public boolean addParticipant(Participant part) {
		  
	
	  
		  query =
				 " INSERT INTO DEV.PARTICIPANT "
				 + "(PARTICIPANTNO, TRIPSHARENO, PARTUSERID, REGDATE)"
				+  "VALUES(PARTICIPANTNO_SEQ.nextval,?,?,sysdate)";


		  System.out.println(query);
		  
		  try { 
		  con = DBcon.getConnection(); 
		  pstmt = con.prepareStatement(query);
		  pstmt.setInt(1,part.getTripshareNo());  
		  pstmt.setString(2,part.getPartuserId()); 
		 
		  
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
