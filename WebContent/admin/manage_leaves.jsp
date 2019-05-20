<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Leaves</title>
<link rel="stylesheet" href="../css/manage_leaves.css" type="text/css" />
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
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
		            <li><a href="#settings">Settings</a></li>
		            <li><a href="../logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
    <div>
    	<center><h3>Manage Leave(s)</h3></center>
	    <form action="" method="POST">
	        <center>
	            <input type="text" name="search_query" placeholder="Filter Search"/>
	            <input type="submit" value="SEARCH" />
	        </center>
	    </form>
    </div>
	    <center>
	    <%
			//String msg = (String)request.getAttribute("msg");
	    	String msg = request.getParameter("msg");
			if(msg!=null){
		%>
		<span><%= msg%></span>
		<%
			}
		%>
		</center>
    <%
       	ResultSet result = null;
       	String sql_search_query = "";
       	PreparedStatement p = null;
       	String query = request.getParameter("search_query");
        Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
        Connection con = DriverManager.getConnection(url);
        if(query==null){
               sql_search_query = "select * from employee_leave order by status desc";
               p = con.prepareStatement(sql_search_query);
           }else{
               sql_search_query = "select * from employee_leave where emp_id LIKE ? or firstname LIKE ? or lastname LIKE ? or department LIKE ? or contact=? or email=? or designation LIKE ? or status=? or reason=? or from_date=? or to_date=? order by status desc";
               p = con.prepareStatement(sql_search_query);
               p.setString(1, "%" + query + "%");
               p.setString(2, "%" + query + "%");
               p.setString(3, "%" + query + "%");
               p.setString(4, "%" + query + "%");
               p.setString(5, "%" + query + "%");
               p.setString(6, "%" + query + "%");
               p.setString(7, "%" + query + "%");
               p.setString(8, "%" + query + "%");
               p.setString(9, "%" + query + "%");
               p.setString(10, "%" + query + "%");
               p.setString(11, "%" + query + "%");
           }
           result = p.executeQuery();
        %>
    <div>
            <table id="employees">        
            <tr>
                <th>Emp ID</th>
                <th>Leave ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Contact No.</th>
                <th>Department</th>
                <th>Designation</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>Status</th>
                <th>Reason</th>
                <th></th>
            </tr>
            <tr>
            <%
            	String color = "";
                    while(result.next()){
            %>
            <td><%= result.getString(1)%></td>
            <td><%= result.getString(2)%></td>
            <%      	
                        for(int i=3;i<=12;i++){
                        	if(i==11){
	                        	if((result.getString(11)).equals("Pending")){
	                        		color = "black";
	                        	}
	                        	else if((result.getString(11)).equals("Approved")){
	                        		color = "green";
	                        	}else{
	                        		color = "red";
	                        	}
             %>
                        	
             <td style="color:<%= color%>;"><%= result.getString(11)%></td>
            
            <%
               	}else{	
            %>
            
             <td><%= result.getString(i)%></td>
            
            <%
               			}
               		}
            %>
            
            <%
            	String emp_id = result.getString(1);
            	String leave_id = result.getString(2);
            %>
                <td>
                <a href="../admin/update_leave.jsp?id=<%= emp_id%>&leave=<%= leave_id%>">Update</a>
                <a href="../admin/delete_leave.jsp?id=<%= emp_id%>&leave=<%= leave_id%>">Delete</a>
                </td>
            </tr>
            
            <% 
            	}
            %>
                
            
            </table>
        </div>
</body>
</html>