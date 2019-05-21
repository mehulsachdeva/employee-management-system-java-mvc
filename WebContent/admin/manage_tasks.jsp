<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.time.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Tasks</title>
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../css/manage_employees.css" type="text/css" />
<style>
#update{
	display: block;
	font-size: 15px;
	color: white;
	padding: 2px 5px;
	width: 15px;
	border: 0;
	border-radius: 2px;
	background: #1D8348;
}
#update:hover{
	background: #229954;
}
#delete{
	margin: 2px 0px;
	display: block;
	font-size: 15px;
	color: white;
	padding: 2px 5px;
	width: 15px;
	border: 0;
	border-radius: 2px;
	background: #A93226;
}
#delete:hover{
	background: #C0392B;
}
</style>
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
	
	<div>
		<center><h3>Manage Task(s)</h3></center>
        <form action="" method="POST">
            <center>
                <input type="text" name="search_query" placeholder="Filter Search"/>
                <input type="submit" value="SEARCH" />
            </center>
        </form>
        <center>
        
        <%
			//String msg = (String)request.getAttribute("msg");
	    	String msg = request.getParameter("msg");
			if(msg!=null){
		%>
		
		<span class="msg"><%= msg%></span>
		
		<%
			}
		%>
		
		</center>
    </div>
    
    <%
       	ResultSet result;
       	String sql_search_query = "";
       	PreparedStatement p;
       	String query = request.getParameter("search_query");
        Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
        Connection con = DriverManager.getConnection(url);
        if(query==null){
            sql_search_query = "select * from employee_task_tracker order by status desc";
            p = con.prepareStatement(sql_search_query);
        }else{
            sql_search_query = "select * from employee_task_tracker where emp_id LIKE ? or task_id LIKE ? or task_name LIKE ? or skills_required LIKE ? or deadline LIKE ? or status LIKE ? order by status desc";
            p = con.prepareStatement(sql_search_query);
            p.setString(1, "%" + query + "%");
            p.setString(2, "%" + query + "%");
            p.setString(3, "%" + query + "%");
            p.setString(4, "%" + query + "%");
            p.setString(5, "%" + query + "%");
            p.setString(6, "%" + query + "%");
        }
        result = p.executeQuery();
     %>
     <div>
	     <table id="employees">
	
	     <tr>
	         <th>Emp ID</th>
	         <th>Task ID</th>
	         <th>Task Name</th>
	         <th>Skills Required</th>
	         <th>Start Date</th>
	         <th>Deadline</th>
	         <th>Status</th>
	         <th></th>
	     </tr>
            
          <%
          	String color = "";
                  while(result.next()){
                      for(int i=1;i<=7;i++){
                      	if(i==7){
                       	if((result.getString(7)).equals("Inactive")){
                       		color = "grey";
                       	}
                       	else if((result.getString(7)).equals("Late")){
                       		color = "red";
                       	}
                       	else if((result.getString(7)).equals("Completed")){
                       		color = "green";
                       	}
                       	else if((result.getString(7)).equals("Completed Late")){
                       		color = "orange";
                       	}
                       	else{
                       		color = "#007FFF";
                       	}
           %>
                        	
          	<td style="color:<%= color%>;"><%= result.getString(7)%></td>
            
            <%
               	}else{		
            %>
                
             <td><%= result.getString(i)%></td>       
            
            <%
               		}
                }
               
            %>
           
            <%	
            	String id = result.getString(1);
            	String task_id = result.getString(2);
            %>
                <td>
                <a href="../admin/update_task.jsp?id=<%= id%>&task_id=<%= task_id%>" id="update"><i class="fa fa-pencil"></i></a>
                <a href="../admin/delete_task.jsp?id=<%= id%>&task_id=<%= task_id%>" id="delete"><i class="fa fa-trash"></i></a>
                </td>
            </tr>
            
            <% 
            	}
            %>

            </table>
        </div>
        
</body>
</html>