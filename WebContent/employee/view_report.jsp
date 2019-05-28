<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.aspire.bean.ReportBean"%>
<%@page import="com.aspire.bean.EmployeeBean"%>
<%@page import="com.aspire.dao.ViewReportDao"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Report</title>
<link rel="stylesheet" href="../css/manage_leaves.css" type="text/css" />
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<% 
		EmployeeBean employeeBean = (EmployeeBean) session.getAttribute("employeeBean");
		String username = null;
		if(employeeBean == null){
			response.sendRedirect("../login.jsp");
		}else{
			username = employeeBean.getUsername();
    %>
     <nav>
   	<div id="logo">Employee Management System</div>

	<label for="drop" class="toggle">Menu</label>
	<input type="checkbox" id="drop" />
	    <ul class="menu">
	        <li><a href="../employee/home_employee.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
	
	        <li>
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-1"/>
		        <ul>
		            <li><a href="../employee/view_tasks.jsp">View Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="../employee/apply_leave.jsp">Apply Leaves</a></li>
		            <li><a href="../employee/view_leaves.jsp">View Leaves</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="attendance" class="toggle">Attendance</label>
		        <a><i class="fa fa-user-plus">&nbsp;Attendance</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="../employee/view_attendance.jsp">View Attendance</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="report" class="toggle">Report</label>
		        <a href="../employee/view_report.jsp"><i class="fa fa-line-chart">&nbsp;Report</i></a>
		        <input type="checkbox" id="drop-4"/>

	        </li>
	        
	        <li>
		        <label for="details" class="toggle">View Details</label>
		        <a href="../employee/view_details.jsp"><i class="fa fa-line-chart">&nbsp;View Details</i></a>
		        <input type="checkbox" id="drop-5"/>

	        </li>
	        
	        <li>
		        <label for="welcome" class="toggle">Welcome <%= username%></label>
		        <a><i class="fa fa-info-circle">&nbsp;Welcome <%= username%></i></a>
		        <input type="checkbox" id="drop-6"/>
		        <ul>
		            <li><a href="../logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
	<div>
	
	<%	
		ViewReportDao viewReportDao = new ViewReportDao();
   		ReportBean reportBean = null;
   		try{
   			reportBean = viewReportDao.viewReport(employeeBean);
   		}catch(Exception e){}

   		if(reportBean != null){
	   		String emp_id = reportBean.getEmp_id();
	   		String department = reportBean.getDepartment();
	   		String designation = reportBean.getDesignation();
	   		double days = Double.valueOf(reportBean.getTotal_working_days());
	   		double present = Double.valueOf(reportBean.getTotal_days_present());
	   		String attendance = reportBean.getAttendance();
	   		String tasks_assigned = reportBean.getTasks_assigned();
	   		String tasks_inactive = reportBean.getTasks_inactive();
	   		String tasks_active = reportBean.getTasks_active();
	   		String tasks_late = reportBean.getTasks_late();
	   		String tasks_completed = reportBean.getTasks_completed();
	   		String tasks_completed_late = reportBean.getTasks_completed_late();
	   		String points = reportBean.getPoints();
	   		String performance = reportBean.getPerformance();
	   		String color = reportBean.getColor();
	%>
	
	<center><h3>Current Report</h3></center>
	<div>
		<table id="employees">
			<tr>
				<td>Employee ID</td>
				<td><%= emp_id %></td>
			</tr>
			<tr>
				<td>Department</td>
				<td><%= department %></td>
			</tr>
			<tr>
				<td>Designation</td>
				<td><%= designation %></td>
			</tr>
			<tr>
				<td>Total Working Days</td>
				<td><%= (int)days %></td>
			</tr>
			<tr>
				<td>Total Days Present</td>
				<td><%= (int)present %></td>
			</tr>
			<tr>
				<td>Attendance</td>
				<td><%= attendance %></td>
			</tr>
			<tr>
				<td>Total Tasks Assigned</td>
				<td><%= tasks_assigned %></td>
			</tr>
			<tr>
				<td>Tasks Inactive</td>
				<td><%= tasks_inactive %></td>
			</tr>
			<tr>
				<td>Tasks Active</td>
				<td><%= tasks_active %></td>
			</tr>
			<tr>
				<td>Tasks Late</td>
				<td><%= tasks_late %></td>
			</tr>
			<tr>
				<td>Tasks Completed</td>
				<td><%= tasks_completed %></td>
			</tr>
			<tr>
				<td>Tasks Completed Late</td>
				<td><%= tasks_completed_late %></td>
			</tr>
			<tr>
				<td>Points</td>
				<td><%= points %>/12</td>
			</tr>
			<tr>
				<td>Performance</td>
				<td><span style="color:<%=color%>"><%= performance%></span></td>
			</tr>
		</table>
	</div>
	<%
   			}
		}
	%>
</body>
</html>