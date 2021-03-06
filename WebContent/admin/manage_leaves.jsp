<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.aspire.bean.AdminBean"%>
<%@page import="com.aspire.dao.SearchBoxDao"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Leaves</title>
<link rel="stylesheet" href="../css/manage_leaves.css" type="text/css" />
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
	
    <div>
    	<center><h3>Manage Leave(s)</h3></center>
	    <form action="" method="POST">
	        <center>
	            <input type="text" name="search_query" placeholder="Filter Search"/>
	            <input type="submit" value="SEARCH" />
	        </center>
	    </form>
    </div>
    
    <center><span class="msg"><%= (request.getParameter("msg") == null)? "": request.getParameter("msg")%></span></center>
	
    <%
	    String search_query = request.getParameter("search_query");
		SearchBoxDao searchBoxDao = new SearchBoxDao();
	    ResultSet result = null;
	    try{
	    	result = searchBoxDao.displayLeaves(search_query);
	    }catch(Exception e){}
	    
	    if(result != null){ 
        
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
                <a href="../admin/update_leave.jsp?id=<%= emp_id%>&leave=<%= leave_id%>" id="update"><i class="fa fa-pencil"></i></a>
                <a href="../admin/delete_leave.jsp?id=<%= emp_id%>&leave=<%= leave_id%>" id="delete"><i class="fa fa-trash"></i></a>
                </td>
            </tr>
            
            <% 
            	}
            %>
                
            
            </table>
        </div>
    <%
			}
		}
    %>
</body>
</html>