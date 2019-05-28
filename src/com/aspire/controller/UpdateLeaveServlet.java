package com.aspire.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aspire.bean.LeaveBean;
import com.aspire.dao.ManageDao;

/**
 * Servlet implementation class UpdateLeaveServlet
 */
@WebServlet("/UpdateLeaveServlet")
public class UpdateLeaveServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String emp_id = request.getParameter("emp_id");
	    String from_date = request.getParameter("from_date");
	    String to_date = request.getParameter("to_date");
	    String status = request.getParameter("status");
	    String reason = request.getParameter("reason");
	    String leave_id = request.getParameter("leave");
	    
	    LeaveBean leaveBean = new LeaveBean();
		
		leaveBean.setFrom_date(from_date);
		leaveBean.setTo_date(to_date);
		leaveBean.setReason(reason);
		leaveBean.setStatus(status);
		
	    ManageDao manageDao = new ManageDao();
	    
	    try {
	    	boolean flag = manageDao.storeUpdatedLeave(leaveBean, leave_id, emp_id);
	    	if(flag) {
	    		String msg = "Leave Updated Successfully";
	    		response.sendRedirect("admin/manage_leaves.jsp?msg=" + msg);
	    	}
	    }catch(Exception e) {
	    	String msg = "Oops...Error In Updating Leave";
    		response.sendRedirect("admin/manage_leaves.jsp?msg=" + msg);
	    }
	}

}
