<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.aspire.bean.EmployeeBean"%>
<%@page import="com.aspire.dao.ViewLeavesDao"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Leaves</title>
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
        ResultSet resultSet = null;
        String emp_id = employeeBean.getEmp_id();
        ViewLeavesDao viewLeavesDao = new ViewLeavesDao();
		try{
			resultSet = viewLeavesDao.viewLeaves(emp_id);
		}catch(Exception e){}
		
       	if(resultSet != null){
    %>
    <center><h3>Leaves</h3></center>
    <div>
            <table id="employees">
                
            <tr>
                <th>Leave ID</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>Status</th>
                <th>Reason</th>
            </tr>
            <%
            	while(resultSet.next()){
            %>
            <td><%= resultSet.getString(1)%></td>
             <td><%= resultSet.getString(2)%></td>
             <td><%= resultSet.getString(3)%></td>
             <td>
             <% 
             	if((resultSet.getString(4)).equals("Pending")){
             %>
             <span style="color:black;"><%= resultSet.getString(4)%></span>
             <%
             	}
             	else if((resultSet.getString(4)).equals("Approved")){
             %>
             <span style="color:green;"><%= resultSet.getString(4)%></span>
             <%
             	}else{
             %>
             <span style="color:red;"><%= resultSet.getString(4)%></span>
             <%
             	}
             %>
             </td>
             <td><%= resultSet.getString(5)%></td>
             </tr>
            <%
            		}
       			}
            %>
            
            </table>
        </div>
     <%
		}
     %>
</body>
</html>