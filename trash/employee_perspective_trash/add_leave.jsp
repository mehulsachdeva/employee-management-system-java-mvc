<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EMP-Leaves</title>
<link rel="stylesheet" href="add_leave.css" type="text/css" />
<link rel="stylesheet" href="../navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
	        <li><a href="#home"><i class="fa fa-home">&nbsp;Home</i></a></li>
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
		        <label for="timeline" class="toggle">Timeline</label>
		        <a><i class="fa fa-clock-o">&nbsp;Timeline</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="add_task.jsp">Add Timesheets</a></li>
		            <li><a href="manage_tasks.jsp">Manage Timesheets</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="add_leave.jsp">Add Leaves</a></li>
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
		        <label for="report" class="toggle">Report</label>
		        <a href="get_report.jsp"><i class="fa fa-line-chart">&nbsp;Report</i></a>
		        <input type="checkbox" id="drop-6"/>

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
     <div>	
     		<%
     			String msg = (String)request.getAttribute("msg");
     			if(msg!=null){
     		%>
     		<center><span class="msg"><%= msg%></span></center>
     		<%
     			}
     		%>
            <form action="add_table_leave.jsp" method="POST">
                                    
            <label for="emp_id">Employee ID</label>
            <input type="text" class="fields" name="emp_id" placeholder="Employee ID" />
                         
            <label for="from_date">From Date</label>
            <input type="text" class="fields" name="from_date" placeholder="DD/MM/YYYY" /><br>
            
            <label for="to_date">To Date</label>
            <input type="text" class="fields" name="to_date" placeholder="DD/MM/YYYY" />
            
            <label for="reason">Reason</label>
            <input type="text" class="fields" name="reason" placeholder="Reason" />
            
            <label for="status">Status</label>
            <select name="status" onchange="this.className=this.options[this.selectedIndex].className" class="Pending">
            	<option class="Pending">Pending</option>
            	<option class="Approved">Approved</option>
            	<option class="Denied">Denied</option>
            </select>
            
            <center>
            	<input type="submit" value="SUBMIT" />
            	<input type="reset" value="RESET" />
            </center>  
        </form>
     </div>
</body>
</html>