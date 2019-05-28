package com.aspire.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aspire.bean.TaskBean;
import com.aspire.dao.TaskDao;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String status = null, color = null;
		String emp_id = request.getParameter("emp_id");
	    String task_name = request.getParameter("task_name");
	    String skills_req = request.getParameter("skills_req");
	    String start_date = request.getParameter("start_date");
	    String deadline = request.getParameter("deadline");
	    
	    TaskBean taskBean = new TaskBean();
	    
	    String arr[] = deadline.split("/");
	    int day = Integer.parseInt(arr[0]);
	    int month = Integer.parseInt(arr[1]);
	    int year = Integer.parseInt(arr[2]);
	    
	    String arr_s[] = start_date.split("/");
	    int day_s = Integer.parseInt(arr_s[0]);
	    int month_s = Integer.parseInt(arr_s[1]);
	    int year_s = Integer.parseInt(arr_s[2]);
	      
	    LocalDate start_line = LocalDate.of(year_s, month_s, day_s);
	    LocalDate end_line = LocalDate.of(year, month, day); 
	    LocalDate today = LocalDate.now();
	    Period diff = Period.between(today, start_line);
	    Period difference = Period.between(today, end_line); //difference between the dates is calculated
	    
	    if(diff.getYears()>0 || diff.getDays()>0 || diff.getMonths()>0){
	    	color = "grey";
	    	status = "Inactive";
	    }else{
	    	if(difference.getYears()<0 || difference.getDays()<0 || difference.getMonths()<0) {
	            color = "red";
	            status = "Late";
	        }else{
		    	color = "black";
		    	status = "Active";
		    }
	    }
	    
	    taskBean.setEmp_id(emp_id);
	    taskBean.setTask_name(task_name);
	    taskBean.setSkills_required(skills_req);
	    taskBean.setStart_date(start_date);
	    taskBean.setDeadline(deadline);
	    taskBean.setStatus(status);
	    taskBean.setColor(color);
	    
	    TaskDao taskDao = new TaskDao();
	    boolean flag = false;
	    
	    try {
	    	flag = taskDao.addTask(taskBean);
	    	if(flag) {
	    		String msg = "Task Added Successfully";
	    		response.sendRedirect("admin/add_task.jsp?msg=" + msg);
	    	}else {
	    		String msg = "Employee Not Found";
	    		response.sendRedirect("admin/add_task.jsp?msg=" + msg);
	    	}
	    }catch(Exception e) {
	    	String msg = "Oops..Error In Adding Tasks";
    		response.sendRedirect("admin/add_task.jsp?msg=" + msg);
	    }

	}

}
