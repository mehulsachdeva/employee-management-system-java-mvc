<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>
<%@page import="com.aspire.bean.AdminBean"%>
<%@page import="com.aspire.dao.AttendanceDao"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Attendance</title>
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="../css/add_attendance.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>

	<% 
		AdminBean adminBean = (AdminBean) session.getAttribute("adminBean");
		String username = null;
		if(adminBean == null){
			response.sendRedirect("../login.jsp");
		}else{
			username = adminBean.getUsername();
    %>    
	<!-- Navigation Bar -->
    <nav>
   		<div id="logo">Employee Management System</div>

		<label for="drop" class="toggle">Menu</label>
		<input type="checkbox" id="drop" />
	    <ul class="menu">
	        <li><a href="../admin/home_admin.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
	        <li>
	            <label for="employees" class="toggle">Employees</label>
	            <a><i class="fa fa-user">&nbsp;Employees</i></a>
	            <input type="checkbox" id="drop-1"/>
	            <ul>
	                <li><a href="../admin/add_employee.jsp">Add Employees</a></li>
	                <li><a href="../admin/manage_employees.jsp">Manage Employees</a></li>
	            </ul> 
	        </li>
	
	        <li>
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="../admin/add_task.jsp">Add Tasks</a></li>
		            <li><a href="../admin/manage_tasks.jsp">Manage Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="../admin/manage_leaves.jsp">Manage Leaves</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="attendance" class="toggle">Attendance</label>
		        <a><i class="fa fa-user-plus">&nbsp;Attendance</i></a>
		        <input type="checkbox" id="drop-5"/>
		        <ul>
		            <li><a href="../admin/add_attendance.jsp">Add Attendance</a></li>
		            <li><a href="../admin/manage_attendance.jsp">Manage Attendance</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="documents" class="toggle">Documents</label>
		        <a><i class="fa fa-book">&nbsp;Documents</i></a>
		        <input type="checkbox" id="drop-6"/>
				 <ul>
		            <li><a href="../admin/get_history.jsp">History</a></li>
		            <li><a href="../admin/get_report.jsp">Report</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="welcome" class="toggle">Welcome <%= username%></label>
		        <a><i class="fa fa-info-circle">&nbsp;Welcome <%= username%></i></a>
		        <input type="checkbox" id="drop-4"/>
		        <ul>
		            <li><a href="../logoutServlet">Logout</a></li>
		        </ul>
	        </li> 
	    </ul>
	</nav>
	
	<%
	    LocalDate now = LocalDate.now();
		String date = now.getDayOfMonth() + "/" + now.getMonthValue() + "/" + now.getYear();

		boolean flag = false;
		AttendanceDao attendanceDao = new AttendanceDao();
		try{
			flag = attendanceDao.checkAttendanceForToday(date);
		}catch(Exception e){}
		if(flag){
	%>	
	
	<center><h3>Attendance Submitted For Today</h3></center>
	
	<%
		}else{
	%>
	
	<center><h3>Attendance For <%= date%></h3></center>
	
	<div>
		<form action="../AttendanceServlet" method="POST">
			<center>
				<label class="label_attendance_upload">
					<i class="fa fa-cloud-upload">&nbsp;&nbsp;</i>Upload CSV File For Attendance&nbsp;
				</label>
				<input type="file" name="attendance_csv" id="attendance_csv" /><br>
			</center>
			
			Mark All Absent 
			<input type="checkbox" id="absent" onchange="markAllAbsent()" />
			<center><b><span id="display-message"></span></b></center>
			<table id="employees">
				<tr>
					<th>Employee ID</th>
					<th>Firstname</th>
					<th>Lastname</th>
					<th>Attendance</th>
				</tr>
				
				<%
					ResultSet result = null;
					try{
						result = attendanceDao.getEmployees();
					}catch(Exception e){}
					if(result != null){
						while(result.next()){
				%>
				
				<tr>
					<td><%= result.getString(1)%></td>
					<td><%= result.getString(2)%></td>
					<td><%= result.getString(3)%></td>
					<td>
						<select name="attendance" onchange="this.className=this.options[this.selectedIndex].className" class="Present">
							<option class="Present">Present</option>
							<option class="Absent">Absent</option>
						</select>
						<input type="hidden" value="<%= date%>" name="date" />
						<input type="hidden" value="<%= result.getString(1)%>" name="emp_id" />
					</td>
				</tr>
				<%
						}
					}
				%>
			</table>
			<center><input type="submit" value="SUBMIT" /></center>
		</form>
	</div>
	
	<%
			}
		}
	%>
	<script src="../js/attendance_updater.js" type="text/javascript"></script>
</body>
</html>