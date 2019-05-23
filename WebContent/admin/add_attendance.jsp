<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Attendance</title>
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="../css/add_attendance.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
		// check for session
		String username = "";
		if(session.getAttribute("login_username")==null){
			response.sendRedirect("../login.jsp");
		}else{
			username = (String)session.getAttribute("login_username");
		}        
	%>
	
	<!-- Navigation Bar -->
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
	
	<%
		// connection with mysql
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
		
	    // get today's date
	    LocalDate now = LocalDate.now();
		String date = now.getDayOfMonth() + "/" + now.getMonthValue() + "/" + now.getYear();
		
		PreparedStatement p = con.prepareStatement("select * from employee_attendance where date=?");
		p.setString(1, date);
		ResultSet res = p.executeQuery();
		if(res.next()){
	%>	
	
	<center><h3>Attendance Submitted For Today</h3></center>
	
	<%
		}else{
	%>
	
	<center><h3>Attendance For <%= date%></h3></center>
	
	<div>
		<form action="../store_attendance" method="POST">
			<center>
				<label class="label_attendance_upload">
					<i class="fa fa-cloud-upload">&nbsp;&nbsp;</i>Upload CSV File For Attendance&nbsp;
				</label>
				<input type="file" name="attendance_csv" id="attendance_csv" /><br>
			</center>
			
			Mark All Absent 
			<input type="checkbox" id="absent" onchange="markAllAbsent()" />
			<center><b><span id="display-message"></span></b></center>
			<table id="employees">
				<tr>
					<th>Employee ID</th>
					<th>Firstname</th>
					<th>Lastname</th>
					<th>Attendance</th>
				</tr>
				
				<%
					PreparedStatement ps = con.prepareStatement("select emp_id, firstname, lastname from employee");
					ResultSet result = ps.executeQuery();
					while(result.next()){
				%>
				
				<tr>
					<td><%= result.getString(1)%></th>
					<td><%= result.getString(2)%></td>
					<td><%= result.getString(3)%></td>
					<td>
						<select name="attendance" onchange="this.className=this.options[this.selectedIndex].className" class="Present">
							<option class="Present">Present</option>
							<option class="Absent">Absent</option>
						</select>
						<input type="hidden" value="<%= date%>" name="date" />
						<input type="hidden" value="<%= result.getString(1)%>" name="emp_id" />
					</td>
				</tr>
				<%
						}
				%>
			</table>
			<center><input type="submit" value="SUBMIT" /></center>
		</form>
	</div>
	
	<%
		}
	%>
	
	<script type="text/javascript">
	
	function markAllAbsent(){
		var absent_checkbox = document.getElementById("absent");
		var elements = document.getElementsByTagName("select");
		if(absent_checkbox.checked==true){			
			for(var i = 0; i < elements.length; i++) {
				elements[i].value = "Absent";
				elements[i].className = "Absent";
			}
		}else{
			for(var i = 0; i < elements.length; i++) {
				elements[i].value = "Present";
				elements[i].className = "Present";
			}
		}
	}
	
	function display(evt){
		var elements = document.getElementsByTagName("select");
		var file = document.getElementById("attendance_csv");
		var f =  evt.target.files[0]; 
		if (f) {
	      var r = new FileReader();
	      r.onload = function(e) { 
		     	var contents = e.target.result;
	        	var array = contents.split("\n");
	        	console.log(array[5]);
	        	for(var i = 0; i < elements.length; i++) {
	        		var arr = array[i+1].split(",");
	        		var str = arr[1].replace(/["]+/g, '').trim();
	        		var val = str.charAt(0).toUpperCase() + str.slice(1);
	        		//console.log(val);
	        		elements[i].value = val;
	        		elements[i].className = val;
	        	}	
	      }
	      //console.log(elements);
	      r.readAsText(f);
	      document.getElementById("display-message").innerHTML = "Attendance Automatically Changed";
		}else{ 
		  alert("Failed to load file. Manually Take Attendance");
		}
	}
	
	document.getElementById("attendance_csv").addEventListener("change", display, false);
	
	</script>
</body>
</html>