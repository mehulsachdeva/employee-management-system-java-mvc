<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
		String id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    
	    PreparedStatement p = con.prepareStatement("delete from employee where emp_id=?");
	    p.setString(1, id);
	    
	    PreparedStatement ps = con.prepareStatement("delete from employee_leave where emp_id=?");
	    ps.setString(1, id);
	    
	    PreparedStatement pf = con.prepareStatement("delete from employee_task_tracker where emp_id=?");
	    pf.setString(1, id);
	    
	    PreparedStatement pa = con.prepareStatement("delete from employee_attendance where emp_id=?");
	    pa.setString(1, id);
	    
	    p.executeUpdate();
	    ps.executeUpdate();
	    pf.executeUpdate();
	    pa.executeUpdate();
	    
	    String msg = "Employee Deleted Successfully";
	    response.sendRedirect("manage_employees.jsp?msg=" + msg);
	%>
</body>
</html>