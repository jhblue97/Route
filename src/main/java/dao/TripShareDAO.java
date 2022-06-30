package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import main.java.dto.TripShare;
import main.java.util.DBcon;
import main.java.vo.TripShareVO;






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
  public List<TripShareVO> getAllTripShare() {
	  List<TripShareVO> tripShareList = new ArrayList<>();
	  query = "SELECT a.TRIPSHARENO, a.USERID, a.COST, a.PARTICIPANT, a.\"TIME\", a.SEX, a.AGE, a.NATION, a.\"STYLE\" "
	  		+ ", a.X1, a.X2,a.X3, a.Y1, a.Y2, a.Y3, a.TITLE1, a.TITLE2, a.TITLE3, a.THEME, a.TRIPDATE "
	  		+ ", count(b.PARTUSERID) AS count_p "
	  		+ "FROM DEV.TRIPSHARE a LEFT OUTER JOIN DEV.PARTICIPANT b ON a.TRIPSHARENO = b.TRIPSHARENO  "
	  		+ "GROUP BY a.TRIPSHARENO, a.USERID, a.COST, a.PARTICIPANT, a.\"TIME\", a.SEX, a.AGE, a.NATION "
	  		+ ", a.\"STYLE\", a.X1, a.X2,a.X3, a.Y1, a.Y2, a.Y3, a.TITLE1, a.TITLE2, a.TITLE3, a.THEME, a.TRIPDATE order by a.tripshareno";

	  System.out.println(query);
	  
	  try { 
	
	  con = DBcon.getConnection(); 
	  pstmt = con.prepareStatement(query);
	  ResultSet rs = pstmt.executeQuery();
	  while(rs.next()) {
		  TripShareVO ts = new TripShareVO();
		  ts.setTripshareNo(rs.getInt(1)); 
		  ts.setUserId(rs.getString(2));
		  ts.setCost(rs.getInt(3));
		  ts.setTotalPartcipant(rs.getInt(4));
		  ts.setTime(rs.getInt(5));
		  ts.setSex(rs.getString(6));
		  ts.setAge(rs.getString(7));
		  ts.setNation(rs.getString(8));
		  ts.setStyle(rs.getString(9));
		  ts.setX1(rs.getFloat(10));
		  ts.setX2(rs.getFloat(11));
		  ts.setX3(rs.getFloat(12));
		  ts.setY1(rs.getFloat(13));
		  ts.setY2(rs.getFloat(14));
		  ts.setY3(rs.getFloat(15));
		  ts.setTitle1(rs.getString(16));
		  ts.setTitle2(rs.getString(17));
		  ts.setTitle3(rs.getString(18));
		  ts.setTheme(rs.getString(19));
		  ts.setTripdate(rs.getString(20)); 
		  ts.setPartcipant(rs.getInt(21));
		  tripShareList.add(ts);
	  }
	  }catch (SQLException e) { // TODO Auto-generated catch block
	  e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return tripShareList; 
	  }

  public List<TripShareVO> myTripShare(String userId) {
	  List<TripShareVO> tripShareList = new ArrayList<>();
	  query = "SELECT a.TRIPSHARENO, a.USERID, a.COST, a.PARTICIPANT, a.\"TIME\", a.SEX, a.AGE, a.NATION, a.\"STYLE\" "
	  		+ ", a.X1, a.X2,a.X3, a.Y1, a.Y2, a.Y3, a.TITLE1, a.TITLE2, a.TITLE3, a.THEME, a.TRIPDATE "
	  		+ ", count(b.PARTUSERID) AS count_p "
	  		+ "FROM DEV.TRIPSHARE a LEFT OUTER JOIN DEV.PARTICIPANT b ON a.TRIPSHARENO = b.TRIPSHARENO WHERE a.USERID  = ? "
	  		+ "GROUP BY a.TRIPSHARENO, a.USERID, a.COST, a.PARTICIPANT, a.\"TIME\", a.SEX, a.AGE, a.NATION "
	  		+ ", a.\"STYLE\", a.X1, a.X2,a.X3, a.Y1, a.Y2, a.Y3, a.TITLE1, a.TITLE2, a.TITLE3, a.THEME, a.TRIPDATE order by a.tripshareno";

	  System.out.println(query);
	  
	  try { 
	
	  con = DBcon.getConnection(); 
	  pstmt = con.prepareStatement(query);
	  pstmt.setString(1,userId); 
	  ResultSet rs = pstmt.executeQuery();
	  while(rs.next()) {
		  TripShareVO ts = new TripShareVO();
		  ts.setTripshareNo(rs.getInt(1)); 
		  ts.setUserId(rs.getString(2));
		  ts.setCost(rs.getInt(3));
		  ts.setTotalPartcipant(rs.getInt(4));
		  ts.setTime(rs.getInt(5));
		  ts.setSex(rs.getString(6));
		  ts.setAge(rs.getString(7));
		  ts.setNation(rs.getString(8));
		  ts.setStyle(rs.getString(9));
		  ts.setX1(rs.getFloat(10));
		  ts.setX2(rs.getFloat(11));
		  ts.setX3(rs.getFloat(12));
		  ts.setY1(rs.getFloat(13));
		  ts.setY2(rs.getFloat(14));
		  ts.setY3(rs.getFloat(15));
		  ts.setTitle1(rs.getString(16));
		  ts.setTitle2(rs.getString(17));
		  ts.setTitle3(rs.getString(18));
		  ts.setTheme(rs.getString(19));
		  ts.setTripdate(rs.getString(20)); 
		  ts.setPartcipant(rs.getInt(21));
		  tripShareList.add(ts);
	  }
	  }catch (SQLException e) { // TODO Auto-generated catch block
	  e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return tripShareList; 
	  }
  public TripShareVO getTripShare(int tripshareNo) {
	  TripShareVO tripShareList = new TripShareVO();
	  query = "SELECT a.TRIPSHARENO, a.USERID, a.COST, a.PARTICIPANT, a.\"TIME\", a.SEX, a.AGE, a.NATION, a.\"STYLE\" "
	  		+ ", a.X1, a.X2,a.X3, a.Y1, a.Y2, a.Y3, a.TITLE1, a.TITLE2, a.TITLE3, a.THEME, a.TRIPDATE "
	  		+ ", count(b.PARTUSERID) AS count_p "
	  		+ "FROM DEV.TRIPSHARE a LEFT OUTER JOIN DEV.PARTICIPANT b ON a.TRIPSHARENO = b.TRIPSHARENO WHERE a.TRIPSHARENO  = ? "
	  		+ "GROUP BY a.TRIPSHARENO, a.USERID, a.COST, a.PARTICIPANT, a.\"TIME\", a.SEX, a.AGE, a.NATION "
	  		+ ", a.\"STYLE\", a.X1, a.X2,a.X3, a.Y1, a.Y2, a.Y3, a.TITLE1, a.TITLE2, a.TITLE3, a.THEME, a.TRIPDATE order by a.tripshareno";

	  System.out.println(query);
	  
	  try { 
	
	  con = DBcon.getConnection(); 
	  pstmt = con.prepareStatement(query);
	  pstmt.setInt(1,tripshareNo); 
	  ResultSet rs = pstmt.executeQuery();
	  while(rs.next()) {
		  TripShareVO ts = new TripShareVO();
		  ts.setTripshareNo(rs.getInt(1)); 
		  ts.setUserId(rs.getString(2));
		  ts.setCost(rs.getInt(3));
		  ts.setTotalPartcipant(rs.getInt(4));
		  ts.setTime(rs.getInt(5));
		  ts.setSex(rs.getString(6));
		  ts.setAge(rs.getString(7));
		  ts.setNation(rs.getString(8));
		  ts.setStyle(rs.getString(9));
		  ts.setX1(rs.getFloat(10));
		  ts.setX2(rs.getFloat(11));
		  ts.setX3(rs.getFloat(12));
		  ts.setY1(rs.getFloat(13));
		  ts.setY2(rs.getFloat(14));
		  ts.setY3(rs.getFloat(15));
		  ts.setTitle1(rs.getString(16));
		  ts.setTitle2(rs.getString(17));
		  ts.setTitle3(rs.getString(18));
		  ts.setTheme(rs.getString(19));
		  ts.setTripdate(rs.getString(20)); 
		  ts.setPartcipant(rs.getInt(21));
	  }
	  }catch (SQLException e) { // TODO Auto-generated catch block
	  e.printStackTrace(); } finally { DBcon.close(pstmt);
	  
	  }
	  return tripShareList; 
	  }

  
	}
