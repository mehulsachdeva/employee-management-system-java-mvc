<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.aspire.bean.EmployeeBean"%>
<%@page import="com.aspire.dao.ViewTasksDao"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tasks</title>
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
        String emp_id = employeeBean.getEmp_id();
        ResultSet resultSet = null;
		ViewTasksDao viewTasksDao = new ViewTasksDao();
   		try{
   			resultSet = viewTasksDao.viewTasks(emp_id);
   		}catch(Exception e){}
   		
   		if(resultSet != null){
     %>
     
     <center><h3>Tasks Assigned</h3></center>
     <div>
            <table id="employees">

            <tr>
                <th>Task Name</th>
                <th>Skills Required</th>
                <th>Start Date</th>
                <th>Deadline</th>
                <th>Status</th>
            </tr>
            
            <%
            	String color = "";
                while(resultSet.next()){
                    for(int i=1;i<=5;i++){
                    	if(i==5){
	                     	if((resultSet.getString(5)).equals("Inactive")){
	                     		color = "grey";
	                     	}
	                     	else if((resultSet.getString(5)).equals("Late")){
	                     		color = "red";
	                     	}
	                     	else if((resultSet.getString(5)).equals("Completed")){
	                     		color = "green";
	                     	}
	                     	else if((resultSet.getString(5)).equals("Completed Late")){
	                     		color = "orange";
	                     	}
	                     	else{
	                     		color = "#007FFF";
	                     	}
             %>
                        	
             <td style="color:<%= color%>;"><%= resultSet.getString(5)%></td>
            
            <%
               	}else{		
            %>
                
             <td><%= resultSet.getString(i)%></td>       
            
            <%
               		}
                }
            %>

            </tr>
            
            <% 
            	} 
            %>
            
            </table>
        </div>
	</div>
	<%
   			}
   		}
	%>
</body>
</html>