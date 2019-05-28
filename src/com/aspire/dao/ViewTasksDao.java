package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.aspire.util.DBConnection;

public class ViewTasksDao {
	public ResultSet viewTasks(String emp_id) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet resultSet = null;
		
		try {
			con = DBConnection.createConnection();
			ps = con.prepareStatement("select task_name, skills_required, start_date, deadline, status from employee_task_tracker where emp_id=? order by status desc");
			ps.setString(1, emp_id);
			resultSet = ps.executeQuery();
			return resultSet;
		}catch(Exception e) {}
		return null;
	}
}
