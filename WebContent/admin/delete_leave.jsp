<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
		String emp_id = request.getParameter("id");
		String leave_id = request.getParameter("leave");
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    PreparedStatement p = con.prepareStatement("delete from employee_leave where emp_id=? and leave_id=?");
	    p.setString(1, emp_id);
	    p.setString(2, leave_id);
	    p.executeUpdate();
	    String msg = "Leave Deleted Successfully";
	    response.sendRedirect("manage_leaves.jsp?msg=" + msg);
	%>
</body>
</html>