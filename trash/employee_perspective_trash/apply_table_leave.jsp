<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>
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
	    String reason = request.getParameter("reason");
	    String status = request.getParameter("status");
	    
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);
		    PreparedStatement ps = con.prepareStatement("select firstname,lastname,email,contact,department,designation from employee where emp_id=?");
		    ps.setString(1, emp_id);
		    ResultSet result = ps.executeQuery();
		    if(result.next()) {
		    	PreparedStatement p = con.prepareStatement("insert into employee_leave(emp_id,firstname,lastname,email,contact,department,designation,from_date,to_date,status,reason) values (?,?,?,?,?,?,?,?,?,?,?)");
			    String firstname = result.getString(1);
			    String lastname = result.getString(2);
			    String email = result.getString(3);
			    String contact = result.getString(4);
			    String department = result.getString(5);
			    String designation = result.getString(6);
		    	p.setString(1, emp_id);
			    p.setString(2, firstname);
			    p.setString(3, lastname);
			    p.setString(4, email);
			    p.setString(5, contact);
			    p.setString(6, department);
			    p.setString(7, designation);
			    p.setString(8, from_date);
			    p.setString(9, to_date);
			    p.setString(10, status);
			    p.setString(11, reason);
			    p.executeUpdate();
			    String msg = "Leave Inserted Successfully";
			    RequestDispatcher rd = request.getRequestDispatcher("add_leave.jsp");
			    request.setAttribute("msg",msg);
			    rd.forward(request, response);
		    }else{
		    	String msg = "No Employee Found";
		    	RequestDispatcher rd = request.getRequestDispatcher("add_leave.jsp");
			    request.setAttribute("msg",msg);
			    rd.forward(request, response);
		    }
		}catch(Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>