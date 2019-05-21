<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Task</title>
<link rel="stylesheet" type="text/css" href="../css/apply_leave.css" />
</head>
<body>

	<%
		String emp_id = request.getParameter("id");
		String task_id = request.getParameter("task_id");
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    PreparedStatement p = con.prepareStatement("select * from employee_task_tracker where emp_id=? and task_id=?");
	    p.setString(1, emp_id);
	    p.setString(2, task_id);
	   	ResultSet result = p.executeQuery();
	   	if(result.next()){
	%>
	
	<form action="../update_task" method="POST">
                                    
            <label for="emp_id">Employee ID</label>
            <input type="text" class="fields" value = "<%= result.getString(1)%>" name="emp_id" placeholder="Employee ID" readonly="readonly"/><br>
 
            <label for="task_name">Task Name</label>
            <input type="text" class="fields" value = "<%= result.getString(3)%>" name="task_name" placeholder="Task Name" />
            
            <label for="skills_req">Skills Required</label>
            <input type="text" class="fields" value = "<%= result.getString(4)%>" name="skills_req" placeholder="Skills Required" />
                         
            <label for="start_date">Start Date</label>
            <input type="text" class="fields" value = "<%= result.getString(5)%>" name="start_date" placeholder="DD/MM/YYYY" /><br>
            
            <label for="deadline">Deadline</label>
            <input type="text" class="fields" value = "<%= result.getString(6)%>" name="deadline" placeholder="DD/MM/YYYY" />
            
            <label for="status">Status</label>
            <input type="text" class="fields" value = "<%= result.getString(7)%>" id="status" name="status" placeholder="Status"  readonly="readonly"/>
            
            <label for="mark">Mark if Completed</label>
            <input type="checkbox" name="mark_for_completion" id="mark_for_completion" onchange="changeVal()"/>
            
            <input type="hidden" value = "<%= result.getString(2)%>" name="task_id"/>
            <input type="hidden" value="<%= result.getString(7)%>" id="default"/>
            <center>
    			<input type="submit" value="UPDATE" />
    		</center>
   	</form>
   	
   	<%
	   	}
   	%>
   	<script type="text/javascript">
    
   	function changeVal(){
   		var flag = document.getElementById("mark_for_completion").checked;
   		var default_val = document.getElementById("default").value;
   		if(flag==true){
   			if(default_val=="Late"){
   				document.getElementById("status").value = "Completed Late";
   			}else{
   				document.getElementById("status").value = "Completed";
   			}
   		}
   		if(flag==false){
   			document.getElementById("status").value = default_val;
   		}
    }
   	
	</script>
</body>
</html>