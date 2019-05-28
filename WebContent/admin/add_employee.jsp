<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.aspire.bean.AdminBean" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Employee</title>
<link rel="stylesheet" href="../css/add_employee.css" type="text/css" />
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<style>
.msg {
    color: red;
    font-size: 15px;
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
        <center><h3>Add Employee</h3></center>
        <center><span class="msg"><%= (request.getParameter("msg") == null)? "": request.getParameter("msg")%></span></center>
 	
       	<form action="../EmployeeServlet" method="POST" enctype="multipart/form-data">
            
            <label for="emp_name">Employee Name</label><br>
            <input type="text" name="emp_fname" class="fname" id="fname" placeholder="First Name" onchange="displayUsername()" required/>
            <input type="text" name="emp_lname" class="lname" id="lname" placeholder="Last Name" onchange="displayUsername()" required/>
            
            <label for="username">Username</label>
            <input type="text" class="fields" id="username" name="username" placeholder="Username" required/>
            
            <label for="password">Password</label>
            <input type="password" class="fields" name="password" placeholder="Password" required/>
            
            <label for="gender">Gender</label>
            <select name="gender">
                <option>Male</option>
                <option>Female</option>
                <option>Others</option>
            </select>
            
            <label for="emp_dob">Date Of Birth</label>
            <input type="text" class="fields" name="emp_dob" placeholder="DD/MM/YYYY" required/>
            
            <label for="emp_email">Email</label>
            <input type="text" class="fields" name="emp_email" placeholder="Email" required/>
            
            <label for="emp_contact">Contact Number</label>
            <input type="text" class="fields" name="emp_contact" placeholder="Contact Number" required/>
            
            <label for="emp_doj">Date Of Joining</label>
            <input type="text" class="fields" name="emp_doj" placeholder="DD/MM/YYYY" required/>
            
            <label for="emp_address">Address</label>
            <input type="text" class="fields" name="emp_address" placeholder="Address" required/>
            
            <label for="emp_department">Department</label>
            <input type="text" class="fields" name="emp_department" placeholder="Department/Division" required/>
            
            <label for="emp_designation">Designation</label>
            <select name="emp_designation">
            	<option>Interns, Part-Time Employees or Temporary Employees</option>
                <option>Employees</option>
                <option>Developer</option>
                <option>Senior Developer</option>
                <option>Junior Developer</option>
                <option>Manager</option>
                <option>Middle Manager of People or a Function</option>
                <option>Director</option>
                <option>Assistant Director</option>
                <option>Senior Director</option>
            </select>
            
            <label for="emp_salary">Salary</label>
            <input type="text" class="fields" name="emp_salary" placeholder="Salary" value="0" required/>
          
            <label for="upload">Upload Employee Passport Size Photo</label><br>
            <figure>
                <img id="preview_photo" src="../images/default_profile.png" width="140" height="150"/>
                <figcaption><input type="file" id="photo" name="passport_photo" /></figcaption>
            </figure>
           <br>
            <input type="submit" value="SUBMIT" />
            <input type="reset" value="RESET" />
            
        </form>
    </div>
    <%
    	} 
    %>
    <script src="../js/profile_previewer.js" type="text/javascript"></script>
</body>
</html>
