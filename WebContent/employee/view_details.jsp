<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.aspire.bean.EmployeeBean" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Details</title>
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../css/manage_employees.css" />
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
	
	<%   		
        String imgDataBase64 = new String(Base64.getEncoder().encode(employeeBean.getPhoto()));
        String emp_id = employeeBean.getEmp_id();
        String fullname = employeeBean.getFirstname() + " " + employeeBean.getLastname();
        String uname = employeeBean.getUsername();
        String gender = employeeBean.getGender();
        String dob = employeeBean.getDob();
        String email = employeeBean.getEmail();
        String contact = employeeBean.getContact();
        String doj = employeeBean.getDoj();
        String address = employeeBean.getAddress();
        String department = employeeBean.getDepartment();
        String designation = employeeBean.getDesignation();
        String salary = employeeBean.getSalary();
	%>
	<center><h3>Details</h3></center>
	<div>
	<table id="employees">
		<tr>
			<td>Employee ID</td>
			<td><%= emp_id %></td>
		</tr>
		<tr>
			<td>Photo and Name</td>
			<td>
				<figure>
					<img src="data:image/gif;base64,<%= imgDataBase64 %>" height="120" width="100" />
					<figcaption><%= fullname %></figcaption>
				</figure>
			</td>
		</tr>
		<tr>
			<td>Username</td>
			<td><%= uname %></td>
		</tr>
		<tr>
			<td>Gender</td>
			<td><%= gender %></td>
		</tr>
		<tr>
			<td>Date Of Birth</td>
			<td><%= dob %></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><%= email %></td>
		</tr>
		<tr>
			<td>Contact</td>
			<td><%= contact %></td>
		</tr>
		<tr>
			<td>Date Of Joining</td>
			<td><%= doj %></td>
		</tr>
		<tr>
			<td>Address</td>
			<td><%= address %></td>
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
			<td>Salary</td>
			<td><%= salary %></td>
		</tr>
	</table>
	</div>
	<%
		}
	%>
</body>
</html>