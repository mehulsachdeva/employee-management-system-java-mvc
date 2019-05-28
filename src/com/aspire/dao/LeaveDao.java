package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.aspire.bean.LeaveBean;
import com.aspire.util.DBConnection;

public class LeaveDao {
	public String applyLeave(LeaveBean leaveBean, String emp_id) {
		String firstname = leaveBean.getFirstname();
		String lastname = leaveBean.getLastname();
		String email = leaveBean.getEmail();
		String contact = leaveBean.getContact();
		String department = leaveBean.getDepartment();
		String designation = leaveBean.getDesignation();
		String from_date = leaveBean.getFrom_date();
		String to_date = leaveBean.getTo_date();
		String reason = leaveBean.getReason();
		String status = leaveBean.getStatus();
		
		Connection con = null;
		PreparedStatement p = null;
		
		try {
			con = DBConnection.createConnection();
			
			p = con.prepareStatement("insert into employee_leave(emp_id, firstname, lastname, email, contact, department, designation, from_date, to_date, reason, status) values(?,?,?,?,?,?,?,?,?,?,?)");
			p.setString(1, emp_id);
			p.setString(2, firstname);
			p.setString(3, lastname);
			p.setString(4, email);
			p.setString(5, contact);
			p.setString(6, department);
			p.setString(7, designation);
			p.setString(8, from_date);
			p.setString(9, to_date);
			p.setString(10, reason);
			p.setString(11, status);
			p.executeUpdate();
			
			return "Leave Applied Successfully";
		}catch(Exception e) {}
		return "Error In Appling Leave";
	}
}
