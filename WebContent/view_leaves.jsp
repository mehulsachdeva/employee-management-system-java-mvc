<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Leaves</title>
<link rel="stylesheet" href="manage_leaves.css" type="text/css" />
<link rel="stylesheet" href="navigation.css" type="text/css" />
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
	        <li><a href="home_employee.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
	
	        <li>
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-1"/>
		        <ul>
		            <li><a href="view_tasks.jsp">View Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="apply_leave.jsp">Apply Leaves</a></li>
		            <li><a href="view_leaves.jsp">View Leaves</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="attendance" class="toggle">Attendance</label>
		        <a><i class="fa fa-user-plus">&nbsp;Attendance</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="view_attendance.jsp">View Attendance</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="report" class="toggle">Report</label>
		        <a href="get_report.jsp"><i class="fa fa-line-chart">&nbsp;Report</i></a>
		        <input type="checkbox" id="drop-4"/>

	        </li>
	        
	        <li>
		        <label for="details" class="toggle">View Details</label>
		        <a href="view_details.jsp"><i class="fa fa-line-chart">&nbsp;View Details</i></a>
		        <input type="checkbox" id="drop-5"/>

	        </li>
	        <li>
		        <label for="welcome" class="toggle">Welcome <%= username%></label>
		        <a><i class="fa fa-info-circle">&nbsp;Welcome <%= username%></i></a>
		        <input type="checkbox" id="drop-6"/>
		        <ul>
		            <li><a href="#settings">Settings</a></li>
		            <li><a href="logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
	
	<div>
	<%
		String id = "";
       	String query = request.getParameter("search_query");
        Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
        Connection con = DriverManager.getConnection(url);
        PreparedStatement ps = con.prepareStatement("select emp_id from employee where username=?");
        ps.setString(1, username);
        ResultSet res = ps.executeQuery();
        if(res.next()){
        	id = res.getString(1);
        }
        
        String sql_search_query = "select leave_id,from_date,to_date,status,reason from employee_leave where emp_id=? order by status desc";
      
        PreparedStatement pi = con.prepareStatement(sql_search_query);
        pi.setString(1, id);
        ResultSet result = pi.executeQuery();
    %>
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
            	while(result.next()){
            %>
            <td><%= result.getString(1)%></td>
             <td><%= result.getString(2)%></td>
             <td><%= result.getString(3)%></td>
             <td>
             <% 
             	if((result.getString(4)).equals("Pending")){
             %>
             <span style="color:black;"><%= result.getString(4)%></span>
             <%
             	}
             	else if((result.getString(4)).equals("Approved")){
             %>
             <span style="color:green;"><%= result.getString(4)%></span>
             <%
             	}else{
             %>
             <span style="color:red;"><%= result.getString(4)%></span>
             <%
             	}
             %>
             </td>
             <td><%= result.getString(5)%></td>
             </tr>
            <%
            	}
            %>
            
       
                
            
            </table>
        </div>
</body>
</html>