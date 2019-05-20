<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
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
			String username = "";
			if(session.getAttribute("login_username")==null){
				response.sendRedirect("../login.jsp");
			}else{
				username = (String)session.getAttribute("login_username");
			}
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
		            <li><a href="#settings">Settings</a></li>
		            <li><a href="../logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
	<div>
	<%
		String emp_id="",department="",designation="";
		String tasks_assigned="", tasks_inactive="", tasks_active="", tasks_completed="", tasks_completed_late="";
		String tasks_late = "";
		int attendance = 0;
		double days=0,present=0;
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    
	    PreparedStatement p = con.prepareStatement("select emp_id, department, designation from employee where username=?");
	    p.setString(1, username);
	    ResultSet result = p.executeQuery();
	    if(result.next()){
	   		emp_id = result.getString(1);
	   		department = result.getString(2);
	   		designation = result.getString(3);
	    }
   		PreparedStatement ps = con.prepareStatement("select count(*), COUNT(IF(attendance='present',1,NULL)) from employee_attendance where emp_id=?");
   		ps.setString(1, emp_id);
   		ResultSet res = ps.executeQuery();
   		if(res.next()){
   			present = Integer.valueOf(res.getString(2));
   			days = Integer.valueOf(res.getString(1));
   			attendance = (int)((present/days)*100);
   		}
   		PreparedStatement pa = con.prepareStatement("select COUNT(*), COUNT(IF(status='Inactive',1,NULL)), COUNT(IF(status='Late',1,NULL)), COUNT(IF(status='Active',1,NULL)), COUNT(IF(status='Completed',1,NULL)), COUNT(IF(status='Completed Late',1,NULL)) from employee_task_tracker where emp_id=?");
   		pa.setString(1, emp_id);
   		ResultSet re = pa.executeQuery();
   		if(re.next()){
   			tasks_assigned = re.getString(1);
   			tasks_inactive = re.getString(2);
   			tasks_late = re.getString(3);
   			tasks_active = re.getString(4);
   			tasks_completed = re.getString(5);
   			tasks_completed_late = re.getString(6);
   		}
   		int late_completion_ratio = 0;
   		if(Integer.parseInt(tasks_completed)!=0){
   			late_completion_ratio = Integer.parseInt(tasks_completed_late)/Integer.parseInt(tasks_completed);
   		}
   		int points = 0;
   		
   		if(attendance>=85)points+=4;
   		else if(attendance<85 && attendance>=75)points+=3;
   		else if(attendance<75 && attendance>=50)points+=2;
   		else points+=1;
   		
   		if(late_completion_ratio<=10)points+=5;
   		else if(late_completion_ratio>10 && late_completion_ratio<=20)points+=3;
   		else if(late_completion_ratio>20 && late_completion_ratio<=30)points+=2;
   		else points += 1;
   		
   		int late = Integer.parseInt(tasks_late);
   		if(late==0)points+=3;
   		else if(late>0 && late<=2)points+=2;
   		else if(late>2 && late<=4)points+=1;
   		else points+=0;
   		
   		String performance = "";
   		String color = "";
   		
   		if(points==11 || points==12){
   			performance = "Outstanding";
   			color = "green";
   		}else if(points>=8 && points<=10){
   			performance = "Satisfactory";
   			color = "blue";
   		}else if(points>=5 && points<=7){
   			performance = "Improvement Needed";
   			color = "orange";
   		}else{
   			performance = "Improvement Needed";
   			color = "red";
   		}
	%>
	<center><h3>Current Report</h3></center>
	<div>
		<table id="employees">
			<tr>
				<td>Employee ID</td>
				<td><%= emp_id%></td>
			</tr>
			<tr>
				<td>Department</td>
				<td><%= department%></td>
			</tr>
			<tr>
				<td>Designation</td>
				<td><%= designation%></td>
			</tr>
			<tr>
				<td>Total Working Days</td>
				<td><%= (int)days%></td>
			</tr>
			<tr>
				<td>Total Days Present</td>
				<td><%= (int)present%></td>
			</tr>
			<tr>
				<td>Attendance</td>
				<td><%= attendance%></td>
			</tr>
			<tr>
				<td>Total Tasks Assigned</td>
				<td><%= tasks_assigned%></td>
			</tr>
			<tr>
				<td>Tasks Inactive</td>
				<td><%= tasks_inactive%></td>
			</tr>
			<tr>
				<td>Tasks Active</td>
				<td><%= tasks_active%></td>
			</tr>
			<tr>
				<td>Tasks Late</td>
				<td><%= tasks_late%></td>
			</tr>
			<tr>
				<td>Tasks Completed</td>
				<td><%= tasks_completed%></td>
			</tr>
			<tr>
				<td>Tasks Completed Late</td>
				<td><%= tasks_completed_late%></td>
			</tr>
			<tr>
				<td>Points</td>
				<td><%= points%>/12</td>
			</tr>
			<tr>
				<td>Performance</td>
				<td><span style="color:<%=color%>"><%= performance%></span></td>
			</tr>
		</table>
	</div>
</body>
</html>