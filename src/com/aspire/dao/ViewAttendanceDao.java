package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aspire.util.DBConnection;

public class ViewAttendanceDao {
	public ResultSet viewAttendance(String emp_id) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet resultSet = null;
		
		try {
			con = DBConnection.createConnection();
			ps = con.prepareStatement("select date, attendance from employee_attendance where emp_id=?");
			ps.setString(1, emp_id);
	        resultSet = ps.executeQuery();
	        return resultSet;
		}catch(Exception e) {}
		return null;
	}
}
