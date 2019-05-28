package com.aspire.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection createConnection() {
		Connection con = null;
		String url = "jdbc:mysql://localhost/test"; //MySQL URL and followed by the database name
		String username = "mehul"; //MySQL username
		String password = "mehul"; //MySQL password
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver"); //loading mysql driver 
			} 
			catch (ClassNotFoundException e){
				e.printStackTrace();
			} 
			
			con = DriverManager.getConnection(url, username, password); //attempting to connect to MySQL database
			System.out.println("Printing connection object " + con);	
			return con;
			
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return con; 
	}
}
