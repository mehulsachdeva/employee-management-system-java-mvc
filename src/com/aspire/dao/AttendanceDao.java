package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aspire.bean.AttendanceBean;
import com.aspire.util.DBConnection;

public class AttendanceDao {
	
	Connection con = null;
	PreparedStatement p = null, pg = null, pi = null, ps = null;
	ResultSet resultSet = null, result = null, res = null;
	
	public boolean checkAttendanceForToday(String date) {
		try {
			con = DBConnection.createConnection();
			p = con.prepareStatement("select * from employee_attendance where date=?");
			p.setString(1, date);
			resultSet = p.executeQuery();
			if(resultSet.next()) {
				return true;
			}
		}catch(Exception e) {}
		return false;
	}
	
	public ResultSet getEmployees() {
		try {
			con = DBConnection.createConnection();
			pg = con.prepareStatement("select emp_id, firstname, lastname from employee");
			result = pg.executeQuery();
			return result;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet getDetailsEmployee(String emp_id) {
		try {
			con = DBConnection.createConnection();
			pi = con.prepareStatement("select firstname, lastname, contact, department, designation from employee where emp_id=?");
			pi.setString(1, emp_id);
			res = pi.executeQuery();
			return res;
		}catch(Exception e) {}
		return null;
	}
	public boolean storeAttendance(AttendanceBean attendanceBean) {
		try {
			String id = attendanceBean.getEmp_id();
			String firstname = attendanceBean.getFirstname();
			String lastname = attendanceBean.getLastname();
			String contact = attendanceBean.getContact();
			String department = attendanceBean.getDepartment();
			String designation = attendanceBean.getDesignation();
			String date = attendanceBean.getDate();
			String mark = attendanceBean.getAttendance();
			
			con = DBConnection.createConnection();
			ps = con.prepareStatement("insert into employee_attendance values (?,?,?,?,?,?,?,?)");
			ps.setString(1, id);
	    	ps.setString(2, firstname);
	    	ps.setString(3, lastname);
	    	ps.setString(4, contact);
	    	ps.setString(5, department);
	    	ps.setString(6, designation);
	    	ps.setString(7, date);
	    	ps.setString(8, mark);
	    	ps.executeUpdate();
	    	return true;
		}catch(Exception e) {}	
		return false;
	}
}
