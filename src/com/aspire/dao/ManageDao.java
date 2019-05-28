package com.aspire.dao;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.Part;

import com.aspire.bean.EmployeeBean;
import com.aspire.bean.LeaveBean;
import com.aspire.bean.TaskBean;
import com.aspire.util.DBConnection;

public class ManageDao {
	public ResultSet getCurrentLeave(String emp_id, String leave_id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		try {
			con = DBConnection.createConnection();
			ps = con.prepareStatement("select * from employee_leave where emp_id=? and leave_id=?");
			ps.setString(1, emp_id);
		    ps.setString(2, leave_id);
		   	result = ps.executeQuery();
		   	return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet getCurrentEmployee(String emp_id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		try {
			con = DBConnection.createConnection();
			ps = con.prepareStatement("select * from employee where emp_id=?");
			ps.setString(1, emp_id);
		   	result = ps.executeQuery();
		   	return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet getCurrentTask(String emp_id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet result = null;
		try {
			con = DBConnection.createConnection();
			ps = con.prepareStatement("select * from employee where emp_id=?");
			ps.setString(1, emp_id);
		   	result = ps.executeQuery();
		   	return result;
		}catch(Exception e) {}
		return null;
	}
	
	public boolean storeUpdatedLeave(LeaveBean leaveBean, String leave_id, String emp_id) {
		String from_date = leaveBean.getFrom_date();
		String to_date = leaveBean.getTo_date();
		String reason = leaveBean.getReason();
		String status = leaveBean.getStatus();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DBConnection.createConnection();
			ps = con.prepareStatement("update employee_leave set from_date=?, to_date=?, status=?, reason=? where emp_id=? and leave_id=?");
			ps.setString(1, from_date);
			ps.setString(2, to_date);
			ps.setString(3, status);
			ps.setString(4, reason);
	       	ps.setString(5, emp_id);
	       	ps.setString(6, leave_id);
	        ps.executeUpdate();
		   	return true;
		}catch(Exception e) {}
		return false;
	}
	
	public boolean storeUpdatedEmployee(EmployeeBean employeeBean, String emp_id) {
		
		String emp_fname = employeeBean.getFirstname();
        String emp_lname = employeeBean.getLastname();
        String password = employeeBean.getPassword();
        String gender = employeeBean.getGender();
        String emp_dob = employeeBean.getDob();
        String emp_email = employeeBean.getEmail();
        String emp_contact = employeeBean.getContact();
        String address = employeeBean.getAddress();
        String department = employeeBean.getDepartment();
        String designation = employeeBean.getDesignation();
        String emp_doj = employeeBean.getDoj();
        String salary = employeeBean.getSalary();
        byte[] photo = employeeBean.getPhoto();
        
		Connection con = null;
		PreparedStatement p = null, ps = null;
		
		try {
			con = DBConnection.createConnection();
			
			if(photo.length != 0) {
				
				InputStream inputStream = new ByteArrayInputStream(photo); 
				
				String query = "update employee set firstname=?, lastname=?, password = ?, gender=?, dob=?, email=?, contact=?, doj=?, address=?, department=?, designation=?, salary=?, photo=? where emp_id=?";
            	p = con.prepareStatement(query);
            	p.setString(1, emp_fname);
                p.setString(2, emp_lname);
                p.setString(3, password);
                p.setString(4, gender);
                p.setString(5, emp_dob);
                p.setString(6, emp_email);
                p.setString(7, emp_contact);
                p.setString(8, emp_doj);
                p.setString(9, address);
                p.setString(10, department);
                p.setString(11, designation);
                p.setString(12, salary);
            	p.setBlob(13, inputStream);
            	p.setString(14, emp_id);
			}else {
				String query = "update employee set firstname=?, lastname=?, password = ?, gender=?, dob=?, email=?, contact=?, doj=?, address=?, department=?, designation=?, salary=? where emp_id=?";
            	p = con.prepareStatement(query);
            	p.setString(1, emp_fname);
                p.setString(2, emp_lname);
                p.setString(3, password);
                p.setString(4, gender);
                p.setString(5, emp_dob);
                p.setString(6, emp_email);
                p.setString(7, emp_contact);
                p.setString(8, emp_doj);
                p.setString(9, address);
                p.setString(10, department);
                p.setString(11, designation);
                p.setString(12, salary);
                p.setString(13, emp_id);
			}
			
			p.executeUpdate();
			
			ps = con.prepareStatement("update history set firstname=?, lastname=?, email=?, doj=?, department=?, designation=? where emp_id=?");
            ps.setString(1, emp_fname);
            ps.setString(2, emp_lname);
            ps.setString(3, emp_email);
            ps.setString(4, emp_doj);
            ps.setString(5, department);
            ps.setString(6, designation);
            ps.setString(7, emp_id);
            ps.executeUpdate();
			
		   	return true;
		}catch(Exception e) {}
		return false;
	}
	public boolean storeUpdatedTask(TaskBean taskBean, String task_id, String emp_id) {
		
		String task_name = taskBean.getTask_name();
		String skills_req = taskBean.getSkills_required();
		String start_date = taskBean.getStart_date();
		String deadline = taskBean.getDeadline();
		String status = taskBean.getStatus();
		
		Connection con = null;
		PreparedStatement p = null;
		
		try {
			con = DBConnection.createConnection();
			String query = "update employee_task_tracker set task_name=?, skills_required=?, start_date=?, deadline=?, status=? where emp_id=? and task_id=?";
	       	p = con.prepareStatement(query);
			p.setString(1, task_name);
			p.setString(2, skills_req);
			p.setString(3, start_date);
	       	p.setString(4, deadline);
	    	p.setString(5, status);
	    	p.setString(6, emp_id);
	    	p.setString(7, task_id);
	        p.executeUpdate();
	        return true;
		}catch(Exception e) {}
		return false;
		
	}
}
