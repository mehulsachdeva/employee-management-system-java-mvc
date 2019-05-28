package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.aspire.util.DBConnection;

public class ViewLeavesDao {
	public ResultSet viewLeaves(String emp_id) throws SQLException {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
				
		try {
			String sql_search_query = "select leave_id,from_date,to_date,status,reason from employee_leave where emp_id=? order by status desc";
	        con = DBConnection.createConnection();
	        ps = con.prepareStatement(sql_search_query);
	        ps.setString(1, emp_id);
	        result = ps.executeQuery();
	        return result;
		}catch(Exception e) {}
		return null;
	}
}
