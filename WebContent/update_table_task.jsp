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
	    String task_id = request.getParameter("task_id");
	    String task_name = request.getParameter("task_name");
	    String skills_req = request.getParameter("skills_req");
	    String start_date = request.getParameter("start_date");
	    String deadline = request.getParameter("deadline");
	    String status = request.getParameter("status");
	    try{
			String query = "";
			PreparedStatement p = null;
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);	   
	       	query = "update employee_task_tracker set task_name=?, skills_required=?, start_date=?, deadline=?, status=? where emp_id=? and task_id=?";
	       	p = con.prepareStatement(query);
			p.setString(1, task_name);
			p.setString(2, skills_req);
			p.setString(3, start_date);
	       	p.setString(4, deadline);
	    	p.setString(5, status);
	    	p.setString(6, emp_id);
	    	p.setString(7, task_id);
	        p.executeUpdate();
	        String msg = "Task Updated Successfully";
		    RequestDispatcher rd = request.getRequestDispatcher("manage_tasks.jsp");
		    request.setAttribute("msg",msg);
		    rd.include(request, response);
		}catch(Exception e) {}
	%>
</body>
</html>