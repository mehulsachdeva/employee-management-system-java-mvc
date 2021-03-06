<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.aspire.dao.ManageDao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Leave</title>
<link rel="stylesheet" type="text/css" href="../css/apply_leave.css" />
</head>
<body>
	
	<%
		String[] status = {"Pending","Approved","Denied"};
		String emp_id = request.getParameter("id");
		String leave_id = request.getParameter("leave");
		ResultSet result = null;
		ManageDao manageDao = new ManageDao();
		try{
			result = manageDao.getCurrentLeave(emp_id, leave_id);
		}catch(Exception e){}
		if(result != null){
	   		if(result.next()){
	%>
	
	<form action="../UpdateLeaveServlet" method="POST">    
   	              
       <label for="emp_id">Employee ID</label>
       <input type="text" class="fields" value="<%= result.getString(1)%>" name="emp_id" placeholder="Employee ID" />
               
       <label for="from_date">From Date</label>
       <input type="text" class="fields" value="<%= result.getString(9)%>" name="from_date" placeholder="DD/MM/YYYY" /><br>
       
       <label for="to_date">To Date</label>
       <input type="text" class="fields" value="<%= result.getString(10)%>" name="to_date" placeholder="DD/MM/YYYY" />
       
       <label for="reason">Reason</label>
       <input type="text" class="fields" value="<%= result.getString(12)%>" name="reason" placeholder="Reason" />

       <input type="hidden" value="<%= leave_id%>" name="leave" />
      
       <%
       		String selectedClass = result.getString(11);
       %>
       
       <label for="status">Status</label>
       <select name="status" onchange="this.className=this.options[this.selectedIndex].className" class="<%= selectedClass%>">
      	
      	<%
       		for(String element: status){
       			if(element.equals(result.getString(11))){
        %>
        
        <option class="<%= element%>" selected="selected"><%= element%></option>
		
		<%
        		}
        		else{
       	%>
       	
       	<option class="<%= element%>"><%= element%></option>
       	
       	<%
        		}
        	}
        %>
        
        </select>
    	<center>
    		<input type="submit" value="UPDATE" />
    	</center>
    </form>
    
	<%
	   		}
		}
	%>
	
</body>
</html>