package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aspire.bean.EmployeeBean;
import com.aspire.bean.ReportBean;
import com.aspire.util.DBConnection;

public class ViewReportDao {
	public ReportBean viewReport(EmployeeBean employeeBean) {
		
		ReportBean reportBean = new ReportBean();
		
		String emp_id = employeeBean.getEmp_id();
		String department = employeeBean.getDepartment();
		String designation = employeeBean.getDesignation();
		
		String tasks_assigned = null, tasks_inactive = null, tasks_active = null;
		String tasks_completed = null, tasks_completed_late = null;
		String tasks_late = null;
		
		int attendance = 0;
		double days = 0, present = 0;
		int points = 0;
		
		Connection con = null;
	    PreparedStatement ps = null, pa = null;
	    ResultSet res = null, re = null;
	    
	    try {
	    	con = DBConnection.createConnection();
	    	ps = con.prepareStatement("select count(*), COUNT(IF(attendance='present',1,NULL)) from employee_attendance where emp_id=?");
	   		ps.setString(1, emp_id);
	   		res = ps.executeQuery();
	   		if(res.next()){
	   			present = Integer.valueOf(res.getString(2));
	   			days = Integer.valueOf(res.getString(1));
	   			attendance = (int)((present/days)*100);
	   		}
	   		pa = con.prepareStatement("select COUNT(*), COUNT(IF(status='Inactive',1,NULL)), COUNT(IF(status='Late',1,NULL)), COUNT(IF(status='Active',1,NULL)), COUNT(IF(status='Completed',1,NULL)), COUNT(IF(status='Completed Late',1,NULL)) from employee_task_tracker where emp_id=?");
	   		pa.setString(1, emp_id);
	   		re = pa.executeQuery();
	   		if(re.next()){
	   			tasks_assigned = re.getString(1);
	   			tasks_inactive = re.getString(2);
	   			tasks_late = re.getString(3);
	   			tasks_active = re.getString(4);
	   			tasks_completed = re.getString(5);
	   			tasks_completed_late = re.getString(6);
	   		}
	   		double late_completion_percent = 0;
	   		double total_tasks_completed = Integer.parseInt(tasks_completed) + Integer.parseInt(tasks_completed_late);
	   		late_completion_percent = (Integer.parseInt(tasks_completed_late)/total_tasks_completed)*100;
	   		
	   		if(attendance>=85)points+=4;
	   		else if(attendance<85 && attendance>=75)points+=3;
	   		else if(attendance<75 && attendance>=50)points+=2;
	   		else points+=1;
	   		
				if(late_completion_percent<=10)points+=5;
	   		else if(late_completion_percent>10 && late_completion_percent<=20)points+=4;
	   		else if(late_completion_percent>20 && late_completion_percent<=30)points+=3;
	   		else if(late_completion_percent>30 && late_completion_percent<=50)points+=2;
	   		else points += 1;
	   		
	   		int late = Integer.parseInt(tasks_late);
	   		if(late==0)points+=3;
	   		else if(late>0 && late<=1)points+=2;
	   		else if(late>1 && late<=2)points+=1;
	   		else points+=0;
	   		
	   		String performance = "";
	   		String color = "";
	   		
	   		if(points==11 || points==12){
	   			performance = "Outstanding";
	   			color = "green";
	   		}else if(points>=8 && points<=10){
	   			performance = "Satisfactory";
	   			color = "blue";
	   		}else if(points>=5 && points<=7){
	   			performance = "Improvement Needed";
	   			color = "orange";
	   		}else{
	   			performance = "Improvement Needed";
	   			color = "red";
	   		}
	   		
	   		reportBean.setAttendance(String.valueOf((int)attendance));
	   		reportBean.setColor(color);
	   		reportBean.setDepartment(department);
	   		reportBean.setDesignation(designation);
	   		reportBean.setPerformance(performance);
	   		reportBean.setPoints(String.valueOf(points));
	   		reportBean.setEmp_id(emp_id);
	   		reportBean.setTasks_assigned(tasks_assigned);
	   		reportBean.setTasks_active(tasks_active);
	   		reportBean.setTasks_completed(tasks_completed);
	   		reportBean.setTasks_completed_late(tasks_completed_late);
	   		reportBean.setTasks_inactive(tasks_inactive);
	   		reportBean.setTasks_late(tasks_late);
	   		reportBean.setTotal_days_present(String.valueOf(present));
	   		reportBean.setTotal_working_days(String.valueOf(days));

	   		return reportBean;
	    }catch(Exception e) {}
   		return null;
	}
	
	public ResultSet displayReport() {
		Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet res = null;
	    
	    try {
	    	con = DBConnection.createConnection();
	    	ps = con.prepareStatement("select emp_id, firstname, lastname, department, designation from employee");
		    res = ps.executeQuery();
		    return res;
	    }catch(Exception e) {}
	    return null;
	}
	
	public ResultSet processAttendance(String emp_id) {
		Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet res = null;
		try {
			con = DBConnection.createConnection();
	   		ps = con.prepareStatement("select count(*), COUNT(IF(attendance='present',1,NULL)) from employee_attendance where emp_id=?");
	   		ps.setString(1, emp_id);
	   		res = ps.executeQuery();
	   		return res;
		}catch(Exception e) {}
		return null;
	}
	
	public ResultSet processTasks(String emp_id) {
		Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet res = null;
		try {
			con = DBConnection.createConnection();
	   		ps = con.prepareStatement("select COUNT(*), COUNT(IF(status='Inactive',1,NULL)), COUNT(IF(status='Late',1,NULL)), COUNT(IF(status='Active',1,NULL)), COUNT(IF(status='Completed',1,NULL)), COUNT(IF(status='Completed Late',1,NULL)) from employee_task_tracker where emp_id=?");
	   		ps.setString(1, emp_id);
	   		res = ps.executeQuery();
	   		return res;
		}catch(Exception e) {}
		return null;
	}
}
