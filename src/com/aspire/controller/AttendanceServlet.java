package com.aspire.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aspire.bean.AttendanceBean;
import com.aspire.dao.AttendanceDao;


@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String firstname = null, lastname = null;
		String contact = null, department = null, designation = null;
		
		String date = request.getParameter("date");
		String[] emp_id = request.getParameterValues("emp_id");
		String[] attendance = request.getParameterValues("attendance");
		
		boolean flag = false;
		
		for(int i = 0; i < emp_id.length; i++) {
			String id = emp_id[i];
	    	String mark = attendance[i];
	    	
			AttendanceBean attendanceBean = new AttendanceBean();
			AttendanceDao attendanceDao = new AttendanceDao();

	    	ResultSet res = attendanceDao.getDetailsEmployee(id);
	    	
	    	try {
	    		if(res.next()) {
		    		firstname = res.getString(1);
			    	lastname = res.getString(2);
			    	contact = res.getString(3);
			    	department = res.getString(4);
			    	designation = res.getString(5);
			    	attendanceBean.setEmp_id(id);
					attendanceBean.setFirstname(firstname);
					attendanceBean.setLastname(lastname);
					attendanceBean.setContact(contact);
					attendanceBean.setDepartment(department);
					attendanceBean.setDesignation(designation);
					attendanceBean.setDate(date);
					attendanceBean.setAttendance(mark);
	    		}
				flag = attendanceDao.storeAttendance(attendanceBean);
				if(!flag) {
					break;
				}
	    	}catch(Exception e) {}
		}
		if(flag) {
			response.sendRedirect("admin/add_attendance.jsp");
		}else {
			String msg = "Oops...Error In Storing Attendance";
			response.sendRedirect("admin/add_attendance.jsp?msg=" + msg);
		}
	}
}
