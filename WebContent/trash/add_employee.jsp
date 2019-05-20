<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
        <link rel="stylesheet" href="add_employee.css" type="text/css" />
        <link rel="stylesheet" href="navigation.css" type="text/css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
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
	        <li><a href="home_admin.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
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
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="add_task.jsp">Add Tasks</a></li>
		            <li><a href="manage_tasks.jsp">Manage Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
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
		        <label for="documents" class="toggle">Documents</label>
		        <a><i class="fa fa-book">&nbsp;Documents</i></a>
		        <input type="checkbox" id="drop-6"/>
				 <ul>
		            <li><a href="get_history.jsp">History</a></li>
		            <li><a href="get_report.jsp">Report</a></li>
		        </ul>
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
        <center>
	        <center><h3>Add Employee</h3></center>
	        <%
	            String error = request.getParameter("error");
	        	String msg = request.getParameter("msg");
	            if(error!=null && msg==null){
	        %>
	        <span class="error"><%= error%></span>
	        <%
	            }
	            else if(error==null && msg!=null){
	        %>
	        <span class="error"><%= msg%></span>
	        <%
				}
			%>
		</center>
        
	       	
            <form action="add_table_employee" method="POST" enctype="multipart/form-data">
            
            <label for="emp_name">Employee Name</label><br>
            <input type="text" name="emp_fname" class="fname" id="fname" placeholder="First Name" onchange="displayUsername()" />
            <input type="text" name="emp_lname" class="lname" id="lname" placeholder="Last Name" onchange="displayUsername()"/>
            
            <label for="username">Username</label>
            <input type="text" class="fields" id="username" name="username" placeholder="Username" />
            
            <label for="password">Password</label>
            <input type="password" class="fields" name="password" placeholder="Password" />
            
            <label for="gender">Gender</label>
            <select name="gender">
                <option>Male</option>
                <option>Female</option>
                <option>Others</option>
            </select>
            
            <label for="emp_dob">Date Of Birth</label>
            <input type="text" class="fields" name="emp_dob" placeholder="DD/MM/YYYY" />
            
            <label for="emp_email">Email</label>
            <input type="text" class="fields" name="emp_email" placeholder="Email" />
            
            <label for="emp_contact">Contact Number</label>
            <input type="text" class="fields" name="emp_contact" placeholder="Contact Number" />
            
            <label for="emp_doj">Date Of Joining</label>
            <input type="text" class="fields" name="emp_doj" placeholder="DD/MM/YYYY" />
            
            <label for="emp_address">Address</label>
            <input type="text" class="fields" name="emp_address" placeholder="Address" />
            
            <label for="emp_department">Department</label>
            <input type="text" class="fields" name="emp_department" placeholder="Department/Division"/>
            
            <label for="emp_designation">Designation</label>
            <select name="emp_designation">
                <option>Employees, Freelancers, Temporary Employees or Part-Time Employees</option>
                <option>Developer</option>
                <option>Senior Developer</option>
                <option>Junior Developer</option>
                <option>Manager</option>
                <option>Middle Manager of people or a function</option>
                <option>Director</option>
                <option>Assistant Director</option>
                <option>Senior Director</option>
            </select>
            
            <label for="emp_salary">Salary</label>
            <input type="text" class="fields" name="emp_salary" placeholder="Salary" value="0"/>
          
            <label for="upload">Upload Employee Passport Size Photo</label><br>
            <figure>
                <img id="preview_photo" src="images/default_profile.png" width="140" height="150"/>
                <figcaption><input type="file" id="photo" name="passport_photo" /></figcaption>
            </figure>
           <br>
            <input type="submit" value="SUBMIT" />
            <input type="reset" value="RESET" />
            
        </form>
        
        <script type="text/javascript">
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function(e) {
                      $('#preview_photo').attr('src', e.target.result);
                    }

                    reader.readAsDataURL(input.files[0]);
                  }
            }
            $("#photo").change(function() {
                readURL(this);
            });
            
            function displayUsername(){
            	var fname = document.getElementById("fname").value.toLowerCase();
            	var lname = document.getElementById("lname").value.toLowerCase();
            	document.getElementById("username").defaultValue = fname + "." + lname;
            }
        </script>
        </div>
    </body>
</html>
