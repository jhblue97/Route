package main.java.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBcon {

	private static Connection con;
	
	private DBcon() {
		
	}
	public static Connection getConnection() {
		
		String driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1521)(host=adb.ap-seoul-1.oraclecloud.com))(connect_data=(service_name=g0cbc321ba1b180_juflower12_medium.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)(ssl_server_cert_dn=\"CN=adb.ap-seoul-1.oraclecloud.com, OU=Oracle ADB SEOUL, O=Oracle Corporation, L=Redwood City, ST=California, C=US\")))";
		//String url = "jdbc:oracle:thin:@juflower12_medium?TNS_ADMIN=/Route/src/main/webapp/resources/wallet";
		String user = "dev";
		String passwd = "Jhblue971124"; 	
		if(con == null ) {
			try {
				Class.forName(driver);
				con= DriverManager.getConnection(url, user, passwd);
				
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
		
		}
		return con;
	}
	public void setCon(Connection con) {
		DBcon.con = con;
	}
	
	
	public static void close() {
		try {
			if(con!=null) con.close();
			
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public static void close(ResultSet rs,Statement stmt) { //SELECT
		try { 
			if(rs!=null) rs.close();
			if(stmt != null) stmt.close();
			
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public static void close(Statement stmt) { //I,D,U
		try {
			if(stmt != null) stmt.close();
			
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public static void close(ResultSet rs,PreparedStatement pstmt) { //SELECT
		try { 
			if(rs!=null) rs.close();
			if(pstmt != null) pstmt.close();
			
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public static void close(PreparedStatement pstmt) { //I,D,U
		try {
			if(pstmt != null) pstmt.close();
			
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
}
