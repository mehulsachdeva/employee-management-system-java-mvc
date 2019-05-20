<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/navigation.css" type="text/css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="../css/manage_employees.css" />
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
        <center><h3>Manage Employee(s)</h3></center>
        <form action="" method="POST">
            <center>
                <input type="text" name="search_query" placeholder="Filter Search"/>
                <input type="submit" value="SEARCH" />
            </center>
        </form>
	        <center>
	        <%    
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
                sql_search_query = "select * from employee";
                p = con.prepareStatement(sql_search_query);
            }else{
                sql_search_query = "select * from employee where emp_id LIKE ? or username LIKE ? or firstname LIKE ? or lastname LIKE ? or gender LIKE ? or department LIKE ? or designation LIKE ? or email LIKE ? or contact LIKE ? or dob LIKE ? or doj LIKE ?";
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
                <th>ID</th>
                <th>Photo</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Username</th>
                <th>Gender</th>
                <th>Date Of Birth</th>
                <th>Email</th>
                <th>Contact No.</th>
                <th>Date Of Joining</th>
                <th>Address</th>
                <th>Department</th>
                <th>Designation</th>
                <th>Salary</th>
                <th></th>
            </tr>
            
            <%
                    while(result.next()){
            %>
            
            <tr>
                <td><%= result.getString(1)%></td>
                
            <%
                Blob image = result.getBlob(15);
                byte[] imgData = image.getBytes(1,(int)image.length());
                String imgDataBase64=new String(Base64.getEncoder().encode(imgData));
            %>
            
            <td><img src="data:image/gif;base64,<%= imgDataBase64 %>" height="120" width="100" /></td>
            
            <% 
                        for(int i=2;i<=14;i++){
                        	if(i!=5){
            %>
            
                <td><%= result.getString(i)%></td>
            
            <%  
                        	}
                        }
            %>
              
            <%
            	String id = result.getString(1);
            %>
                <td>
                <a href="../admin/update_employee.jsp?id=<%= id%>">Update</a>
                <a href="../admin/delete_employee.jsp?id=<%= id%>">Delete</a>
                </td>
            </tr>
            
            <% 
            	}
            %>
                
            
            </table>
        </div>
    </body>
</html>
