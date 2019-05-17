<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String emp_id = request.getParameter("emp_id");
    String from_date = request.getParameter("from_date");
    String to_date = request.getParameter("to_date");
    String status = request.getParameter("status");
    String reason = request.getParameter("reason");
    String leave_id = request.getParameter("leave");
	try{
		String query = "";
		PreparedStatement p = null;
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);	   
       	query = "update employee_leave set from_date=?, to_date=?, status=?, reason=? where emp_id=? and leave_id=?";
       	p = con.prepareStatement(query);
		p.setString(1, from_date);
		p.setString(2, to_date);
		p.setString(3, status);
		p.setString(4, reason);
       	p.setString(5, emp_id);
       	p.setString(6, leave_id);
        p.executeUpdate();
        String msg = "Leave Updated Successfully";
	    RequestDispatcher rd = request.getRequestDispatcher("manage_leaves.jsp");
	    request.setAttribute("msg",msg);
	    rd.include(request, response);
	}catch(Exception e) {}
	%>
</body>
</html>