package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Set;

import com.aspire.bean.TaskBean;
import com.aspire.util.DBConnection;

public class TaskDao {
public boolean addTask(TaskBean taskBean) {
		
		String emp_id = taskBean.getEmp_id();
		String task_name = taskBean.getTask_name();
		String skills_req = taskBean.getSkills_required();
		String start_date = taskBean.getStart_date();
		String deadline = taskBean.getDeadline();
		String status = taskBean.getStatus();
		
		Connection con = null;
		PreparedStatement p = null, ps = null, pcheck = null, ph = null;
		ResultSet result = null, r = null, rget = null;
		try {
			con = DBConnection.createConnection();
			p = con.prepareStatement("select * from employee where emp_id=?");
		    p.setString(1, emp_id);
		    result = p.executeQuery();
		    if(result.next()) {	
				ps = con.prepareStatement("insert into employee_task_tracker(emp_id, task_name, skills_required, start_date, deadline, status) values (?,?,?,?,?,?)");
	            ps.setString(1, emp_id);
	            ps.setString(2, task_name);
	            ps.setString(3, skills_req);
	            ps.setString(4, start_date);
	            ps.setString(5, deadline);
	            ps.setString(6, status);
	            ps.executeUpdate();
	            pcheck = con.prepareStatement("select * from history where emp_id=?");
	            pcheck.setString(1, emp_id);
	            r = pcheck.executeQuery();
	            if(r.next()){
	            	Set<String> tasks_names = new HashSet<String>();
	            	Set<String> skills_names = new HashSet<String>();
	            	String tasks = "";
	            	String skills = "";
	            	PreparedStatement pget = con.prepareStatement("select task_name, skills_required from employee_task_tracker where emp_id=?");
	            	pget.setString(1, emp_id);
	            	rget = pget.executeQuery();
	            	while(rget.next()){
	            		tasks_names.add(rget.getString(1));
	            		skills_names.add(rget.getString(2));
	            	}
	            	for(String element: tasks_names) {
	            		tasks += element + ",";
	            	}
	            	for(String element: skills_names) {
	            		skills += element + ",";
	            	}
	            	ph = con.prepareStatement("update history set tasks=?, skills=? where emp_id=?");
	                ph.setString(1, tasks);
	                ph.setString(2, skills);
	                ph.setString(3, emp_id);
	                ph.executeUpdate();
	            }
		    }
		    return true;
		}catch(Exception e) {}
		return false;
	}
}
