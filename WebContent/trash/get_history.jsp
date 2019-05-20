<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>History</title>
<link rel="stylesheet" href="navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="manage_employees.css" />
</head>
<body>
	<% 
         String username = (String)session.getAttribute("login_username");
     %>
        <nav>
   	<div id="logo">Employee Management System</div>

	<label for="drop" class="toggle">Menu</label>
	<input type="checkbox" id="drop" />
	    <ul class="menu">
	        <li><a href="home_admin.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
	        <li>
	            <label for="employees" class="toggle">Employees</label>
	            <a><i class="fa fa-user">&nbsp;Employees</i></a>
	            <input type="checkbox" id="drop-1"/>
	            <ul>
	                <li><a href="add_employee.jsp">Add Employees</a></li>
	                <li><a href="manage_employees.jsp">Manage Employees</a></li>
	            </ul> 
	        </li>
	
	        <li>
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="add_task.jsp">Add Tasks</a></li>
		            <li><a href="manage_tasks.jsp">Manage Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="manage_leaves.jsp">Manage Leaves</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="attendance" class="toggle">Attendance</label>
		        <a><i class="fa fa-user-plus">&nbsp;Attendance</i></a>
		        <input type="checkbox" id="drop-5"/>
		        <ul>
		            <li><a href="add_attendance.jsp">Add Attendance</a></li>
		            <li><a href="manage_attendance.jsp">Manage Attendance</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="documents" class="toggle">Documents</label>
		        <a><i class="fa fa-book">&nbsp;Documents</i></a>
		        <input type="checkbox" id="drop-6"/>
				 <ul>
		            <li><a href="get_history.jsp">History</a></li>
		            <li><a href="get_report.jsp">Report</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="welcome" class="toggle">Welcome <%= username%></label>
		        <a><i class="fa fa-info-circle">&nbsp;Welcome <%= username%></i></a>
		        <input type="checkbox" id="drop-4"/>
		        <ul>
		            <li><a href="#settings">Settings</a></li>
		            <li><a href="logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
	<center><h3>History Of Employees</h3></center>
	<div>
		<table id="employees">
		<tr>	
			<th>Emp ID</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Email</th>
			<th>Date Of Joining</th>
			<th>Department</th>
			<th>Designation</th>
			<th>Tasks Worked On</th>
			<th>Skills</th>
			<th>Year Joined</th>
		</tr>
		
	<%
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    PreparedStatement ps = con.prepareStatement("select * from history");
	    ResultSet result = ps.executeQuery();
	    while(result.next()){
	%>
		<tr>
			<td><%= result.getString(1)%></td>
			<td><%= result.getString(2)%></td>
			<td><%= result.getString(3)%></td>
			<td><%= result.getString(4)%></td>
			<td><%= result.getString(5)%></td>
			<td><%= result.getString(6)%></td>
			<td><%= result.getString(7)%></td>
			<td><%= result.getString(8)%></td>
			<td><%= result.getString(9)%></td>
			<td><%= result.getString(10)%></td>
		<tr>
	<%
	    }
	%>
		</table>
	</div>
</body>
</html>