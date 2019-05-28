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
import com.aspire.dao.ManageDao;


@WebServlet("/UpdateTaskServlet")
public class UpdateTaskServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String color = null;
		String emp_id = request.getParameter("emp_id");
	    String task_id = request.getParameter("task_id");
	    String task_name = request.getParameter("task_name");
	    String skills_req = request.getParameter("skills_req");
	    String start_date = request.getParameter("start_date");
	    String deadline = request.getParameter("deadline");
	    String status = request.getParameter("status");
	    
	    TaskBean taskBean = new TaskBean();
	    
	    if(status.equals("Inactive")){
       		color = "grey";
       	}
       	else if(status.equals("Late")){
       		color = "red";
       	}
       	else if(status.equals("Completed")){
       		color = "green";
       	}
       	else if(status.equals("Completed Late")){
       		color = "orange";
       	}
       	else{
       		color = "#007FFF";
       	}
	    
	    taskBean.setEmp_id(emp_id);
	    taskBean.setTask_name(task_name);
	    taskBean.setSkills_required(skills_req);
	    taskBean.setStart_date(start_date);
	    taskBean.setDeadline(deadline);
	    taskBean.setStatus(status);
	    taskBean.setColor(color);
	    
	    ManageDao manageDao = new ManageDao();
	    
	    try {
	    	boolean flag = manageDao.storeUpdatedTask(taskBean, task_id, emp_id);
	    	if(flag) {
	    		String msg = "Task Updated Successfully";
	    		response.sendRedirect("admin/manage_tasks.jsp?msg=" + msg);
	    	}
	    }catch(Exception e) {
	    	String msg = "Oops...Error In Updating Task";
    		response.sendRedirect("admin/manage_tasks.jsp?msg=" + msg);
	    }
	}

}
