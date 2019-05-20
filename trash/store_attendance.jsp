<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
	<%
		
		String firstname = "", lastname = "", contact = "", department = "", designation = "";
		String date = request.getParameter("date");
		String[] emp_id = request.getParameterValues("emp_id");
		String[] attendance = request.getParameterValues("attendance");
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    for(int i = 0; i < emp_id.length; i++) {
	    	String id = emp_id[i];
	    	String mark = attendance[i];
	    	PreparedStatement p = con.prepareStatement("select firstname, lastname, contact, department, designation from employee where emp_id=?");
	    	p.setString(1, id);
	    	ResultSet res = p.executeQuery();
	    	if(res.next()){
	    		firstname = res.getString(1);
	    		lastname = res.getString(2);
	    		contact = res.getString(3);
	    		department = res.getString(4);
	    		designation = res.getString(5);
	    	}
	    	PreparedStatement ps = con.prepareStatement("insert into employee_attendance values (?,?,?,?,?,?,?,?)");
	    	ps.setString(1, id);
	    	ps.setString(2, firstname);
	    	ps.setString(3, lastname);
	    	ps.setString(4, contact);
	    	ps.setString(5, department);
	    	ps.setString(6, designation);
	    	ps.setString(7, date);
	    	ps.setString(8, mark);
	    	ps.executeUpdate();
	    }
	    response.sendRedirect("add_attendance.jsp");
	    
	%>
</body>
</html>