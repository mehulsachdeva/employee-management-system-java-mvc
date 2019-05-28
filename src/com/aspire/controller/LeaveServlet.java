package com.aspire.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aspire.bean.LeaveBean;
import com.aspire.bean.EmployeeBean;
import com.aspire.dao.LeaveDao;


@WebServlet("/LeaveServlet")
public class LeaveServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		EmployeeBean employeeBean = (EmployeeBean) session.getAttribute("employeeBean");
		String emp_id = employeeBean.getEmp_id();
		String firstname = employeeBean.getFirstname();
		String lastname = employeeBean.getLastname();
		String email = employeeBean.getEmail();
		String contact = employeeBean.getContact();
		String department = employeeBean.getDepartment();
		String designation = employeeBean.getDesignation();
		String from_date = request.getParameter("from_date");
		String to_date = request.getParameter("to_date");
		String reason = request.getParameter("reason");
		String status = "Pending";
		
		LeaveBean leaveBean = new LeaveBean();
		
		leaveBean.setFirstname(firstname);
		leaveBean.setLastname(lastname);
		leaveBean.setEmail(email);
		leaveBean.setContact(contact);
		leaveBean.setDepartment(department);
		leaveBean.setDesignation(designation);
		leaveBean.setFrom_date(from_date);
		leaveBean.setTo_date(to_date);
		leaveBean.setReason(reason);
		leaveBean.setStatus(status);
		
		LeaveDao leaveDao = new LeaveDao();
		
		try {
			String result = leaveDao.applyLeave(leaveBean, emp_id);
			if(result.equals("Leave Applied Successfully")) {
				response.sendRedirect("employee/apply_leave.jsp?msg=" + result);
			}else {
				response.sendRedirect("employee/apply_leave.jsp?msg=" + result);
			}
		}catch(Exception e) {}
	}

}
