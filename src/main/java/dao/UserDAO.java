package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import main.java.dto.Users;
import main.java.util.DBcon;






public class UserDAO {

	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String query;
	private boolean result;
	


	  /*public boolean deleteUser(String userId) {
			  
		
		  
			  query =
			  "delete from USERS where userid = ?"
			  ; System.out.println(query);
			  
			  try { 
			  con = DBcon.getConnection(); 
			  pstmt = con.prepareStatement(query);
			  pstmt.setString(1,userId); 
	
			  if(pstmt.executeUpdate()==1) { 
				   System.out.println("delete  ok"); 
				  result = true;
			  
			  }else { 
				  System.out.println("delete not ok");
			  
			  result = false; 
			  }
			  }catch (SQLException e) { // TODO Auto-generated catch block
			  e.printStackTrace(); } finally { DBcon.close(pstmt);
			  
			  }
			  return result; 
	 }*/
	  
	
  /*public boolean addUser(Users user) {
		  
	  System.out.println(user.getUserName());
	  
		  query =
		  "INSERT INTO USERS"
		  + "(USERID, USERNAME, PWD, GRADENO,REGDATE)"
		  + "VALUES(?,?,?,?,SYSDATE)"
		  + ""
		  ; System.out.println(query);
		  
		  try { 
		  con = DBcon.getConnection(); 
		  pstmt = con.prepareStatement(query);
		  pstmt.setString(1,user.getUserID()); 
		  pstmt.setString(2,user.getUserName());
		  pstmt.setString(3,user.getPwd()); 
		  pstmt.setString(4,user.getGradeNo());
		  
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
		  }*/
  

  public Users getUser(String userId,String pwd) {
		   
		Users user = new Users();
		
	  int count = 0;
		  query =
		//  "SELECT * FROM USERS WHERE USERID = '"+userId+"' AND pwd = '"+pwd+"'";
		  "SELECT * FROM dev.USERS ";
		  try {		
				con = DBcon.getConnection();
				stmt = con.createStatement();			
				rs = stmt.executeQuery(query); //5 		
				if(rs.next()) {
					user.setUserID(rs.getString("USERID"));
					user.setUserName(rs.getString("userName"));
					user.setPwd(rs.getString("pwd"));	
					user.setBirth(rs.getString("BIRTH"));
					user.setSex(rs.getString("sex"));
					user.setNation(rs.getString("nation"));
				}		
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DBcon.close(stmt);			
			}
			
		  return user;
  }

/*	  public int checkId(String userId) {
			  
		 
		  int count = 0;
			  query =
			  "SELECT COUNT(*) COUNT FROM USERS WHERE USERID = '"+userId+"'";
			  
			  try {		
					con = DBcon.getConnection();
					stmt = con.createStatement();			
					rs = stmt.executeQuery(query); //5 		
					if(rs.next()) {
					    if(rs.getInt("count")==0) { 	
					    	count = 0;
					    }else {
					    	count = 1;
					    }
					    
					}		
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					DBcon.close(stmt);			
				}
				
			  return count;
	  }*/
	}
