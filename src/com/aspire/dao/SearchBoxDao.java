package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aspire.util.DBConnection;

public class SearchBoxDao {
	public ResultSet displayHistory(String search_query) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		try {
			con = DBConnection.createConnection();
			if(search_query == null) {
				ps = con.prepareStatement("select * from history");
			}else {
				String query = "select * from history where emp_id LIKE ? or firstname LIKE ? or lastname LIKE ? or department LIKE ? or designation LIKE ? or doj LIKE ? or year LIKE ?";
				ps = con.prepareStatement(query);
	            ps.setString(1, "%" + search_query + "%");
	            ps.setString(2, "%" + search_query + "%");
	            ps.setString(3, "%" + search_query + "%");
	            ps.setString(4, "%" + search_query + "%");
	            ps.setString(5, "%" + search_query + "%");
	            ps.setString(6, "%" + search_query + "%");
	            ps.setString(7, "%" + search_query + "%");
			}
            result = ps.executeQuery();
            return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet displayAttendance(String search_query) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		try {
			con = DBConnection.createConnection();
			if(search_query == null) {
				ps = con.prepareStatement("select * from employee_attendance");
			}else {
				String query = "select * from employee_attendance where emp_id LIKE ? or firstname LIKE ? or lastname LIKE ? or department LIKE ? or designation LIKE ? or contact LIKE ? or date LIKE ?";
		        ps = con.prepareStatement(query);
		        ps.setString(1, "%" + search_query + "%");
		        ps.setString(2, "%" + search_query + "%");
		        ps.setString(3, "%" + search_query + "%");
		        ps.setString(4, "%" + search_query + "%");
		        ps.setString(5, "%" + search_query + "%");
		        ps.setString(6, "%" + search_query + "%");
		        ps.setString(7, "%" + search_query + "%");
			}
			result = ps.executeQuery();
			return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet displayEmployees(String search_query) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		
		try {
			con = DBConnection.createConnection();
			if(search_query == null) {
				ps = con.prepareStatement("select * from employee");
			}else {
				String query = "select * from employee where emp_id LIKE ? or username LIKE ? or firstname LIKE ? or lastname LIKE ? or gender LIKE ? or department LIKE ? or designation LIKE ? or email LIKE ? or contact LIKE ? or dob LIKE ? or doj LIKE ?";
		        ps = con.prepareStatement(query);
		        ps.setString(1, "%" + search_query + "%");
		        ps.setString(2, "%" + search_query + "%");
		        ps.setString(3, "%" + search_query + "%");
		        ps.setString(4, "%" + search_query + "%");
		        ps.setString(5, "%" + search_query + "%");
		        ps.setString(6, "%" + search_query + "%");
		        ps.setString(7, "%" + search_query + "%");
		        ps.setString(8, "%" + search_query + "%");
		        ps.setString(9, "%" + search_query + "%");
		        ps.setString(10, "%" + search_query + "%");
		        ps.setString(11, "%" + search_query + "%");
			}
			result = ps.executeQuery();
			return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet displayLeaves(String search_query) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		
		try {
			con = DBConnection.createConnection();
			if(search_query == null) {
				ps = con.prepareStatement("select * from employee_leave order by status desc");
			}else {
				String query = "select * from employee_leave where emp_id LIKE ? or firstname LIKE ? or lastname LIKE ? or department LIKE ? or contact=? or email=? or designation LIKE ? or status=? or reason=? or from_date=? or to_date=? order by status desc";
		        ps = con.prepareStatement(query);
		        ps.setString(1, "%" + search_query + "%");
		        ps.setString(2, "%" + search_query + "%");
		        ps.setString(3, "%" + search_query + "%");
		        ps.setString(4, "%" + search_query + "%");
		        ps.setString(5, "%" + search_query + "%");
		        ps.setString(6, "%" + search_query + "%");
		        ps.setString(7, "%" + search_query + "%");
		        ps.setString(8, "%" + search_query + "%");
		        ps.setString(9, "%" + search_query + "%");
		        ps.setString(10, "%" + search_query + "%");
		        ps.setString(11, "%" + search_query + "%");
			}
			result = ps.executeQuery();
			return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet displayTasks(String search_query) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		
		try {
			con = DBConnection.createConnection();
			if(search_query == null) {
				ps = con.prepareStatement("select * from employee_task_tracker order by status desc");
			}else {
				String query = "select * from employee_task_tracker where emp_id LIKE ? or task_id LIKE ? or task_name LIKE ? or skills_required LIKE ? or deadline LIKE ? or status LIKE ? order by status desc";
		        ps = con.prepareStatement(query);
		        ps.setString(1, "%" + search_query + "%");
		        ps.setString(2, "%" + search_query + "%");
		        ps.setString(3, "%" + search_query + "%");
		        ps.setString(4, "%" + search_query + "%");
		        ps.setString(5, "%" + search_query + "%");
		        ps.setString(6, "%" + search_query + "%");
			}
			result = ps.executeQuery();
			return result;
		}catch(Exception e) {}
		return null;
	}
}
