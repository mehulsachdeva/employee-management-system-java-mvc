<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.aspire.bean.AdminBean" %>
<%@ page import="com.aspire.dao.ViewReportDao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Report</title>
<link rel="stylesheet" href="../css/manage_leaves.css" type="text/css" />
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<style>
#print{
	width: 150px;
	background: #6C3483;
    height: 23px;
    display: inline-block;
    border: 0;
    border-radius: 2px;
    color: white;
    margin: 6px -5px;
    padding: 4px 4px;
    cursor: pointer;
}
#print:hover{
	background: #8E44AD;
}
</style>

<body>

	<% 
		AdminBean adminBean = (AdminBean) session.getAttribute("adminBean");
		String username = null;
		if(adminBean == null){
			response.sendRedirect("../login.jsp");
		}else{
			username = adminBean.getUsername();
    %>
    
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
	
	<center><h3>Employee(s) Report</h3></center>
	
	<div style="position: absolute;left: 20px;top:75px;"><button id="print" onclick="window.print()" />PRINT REPORT</button></div>
	
	<div>
		<table id="employees">
		<tr>
			<th>Emp ID</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Department</th>
			<th>Designtion</th>
			<th>Attendance %</th>
			<th>Tasks Assigned</th>
			<th>Tasks Inactive</th>
			<th>Tasks Active</th>
			<th>Tasks Behind Schedule</th>
			<th>Tasks Completed On Time</th>
			<th>Tasks Completed Late</th>
			<th>Points</th>
			<th>Performance</th>				
		</tr> 	
		<%
			
			String emp_id = null, firstname = null, lastname = null, department = null, designation = null;
			String tasks_assigned = null, tasks_inactive = null, tasks_active = null, tasks_completed = null, tasks_completed_late = null;
			String tasks_late = null;

			ViewReportDao viewReportDao = new ViewReportDao();
			ResultSet result = null, res = null, re = null;
			
			try{
				result = viewReportDao.displayReport();	
			}catch(Exception e){}
			
		   	while(result.next()){
		   		int attendance = 0;
		   		emp_id = result.getString(1);
		   		firstname = result.getString(2);
		   		lastname = result.getString(3);
		   		department = result.getString(4);
		   		designation = result.getString(5);
				
		   		res = viewReportDao.processAttendance(emp_id);
		   		if(res.next()){
		   			double present = Integer.valueOf(res.getString(2));
		   			double days = Integer.valueOf(res.getString(1));
		   			attendance = (int)((present/days)*100);
		   		}
		   		
		   		re = viewReportDao.processTasks(emp_id);
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
		   		
		   		int points = 0;
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
		   		}else if(points>=7 && points<=10){
		   			performance = "Satisfactory";
		   			color = "blue";
		   		}else if(points>=5 && points<=6){
		   			performance = "Improvement Needed";
		   			color = "orange";
		   		}else{
		   			performance = "Improvement Needed";
		   			color = "red";
		   		}
		%>
	
		<tr>
			<td><%= emp_id%></td>
			<td><%= firstname%></td>
			<td><%= lastname%></td>
			<td><%= department%></td>
			<td><%= designation%></td>
			<td><%= attendance%></td>
			<td><%= tasks_assigned%></td>
			<td><%= tasks_inactive%></td>
			<td><%= tasks_active%></td>
			<td><%= tasks_late%></td>
			<td><%= tasks_completed%></td>
			<td><%= tasks_completed_late%></td>	
			<td><%= points%></td>		
			<td><span style="color:<%= color%>;"><%= performance%></span></td>
		</tr> 	
				
		<%
		   	} 
		%>
		
		</table>
	</div>
	<%
		}
	%>
</body>
</html>