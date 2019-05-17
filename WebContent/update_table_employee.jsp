<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*" %>
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
	    String emp_fname = request.getParameter("emp_fname");
	    String emp_lname = request.getParameter("emp_lname");
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String gender = request.getParameter("gender");
	    String emp_dob = request.getParameter("emp_dob");
	    String emp_email = request.getParameter("emp_email");
	    String emp_contact = request.getParameter("emp_contact");
	    String address = request.getParameter("emp_address");
	    String department = request.getParameter("emp_department");
	    String designation = request.getParameter("emp_designation");
	    String emp_doj = request.getParameter("emp_doj");
	    String salary = request.getParameter("emp_salary");
		try{
			String query = "";
			PreparedStatement p = null;
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);
		    Part filePart = request.getPart("passport_photo");
		    InputStream inputStream = filePart.getInputStream();
	        if(filePart.getSize()!=0) {
	        	query = "update employee set firstname=?, lastname=?, username=?, password=?, gender=?, dob=?, email=?, contact=?, doj=?, address=?, department=?, designation=?, salary=?, photo=? where emp_id=?";
	        	p = con.prepareStatement(query);
	        	p.setString(1, emp_fname);
	            p.setString(2, emp_lname);
	            p.setString(3, username);
	            p.setString(4, password);
	            p.setString(5, gender);
	            p.setString(6, emp_dob);
	            p.setString(7, emp_email);
	            p.setString(8, emp_contact);
	            p.setString(9, emp_doj);
	            p.setString(10, address);
	            p.setString(11, department);
	            p.setString(12, designation);
	            p.setString(13, salary);
	        	p.setBlob(14, inputStream);
	        	p.setString(15, emp_id);
	        }else {
	        	query = "update employee set firstname=?, lastname=?, gender=?, dob=?, email=?, contact=?, doj=?, address=?, department=?, designation=?, salary=? where emp_id=?";
	        	p = con.prepareStatement(query);
	        	p.setString(1, emp_fname);
	            p.setString(2, emp_lname);
	            p.setString(3, gender);
	            p.setString(4, emp_dob);
	            p.setString(5, emp_email);
	            p.setString(6, emp_contact);
	            p.setString(7, emp_doj);
	            p.setString(8, address);
	            p.setString(9, department);
	            p.setString(10, designation);
	            p.setString(11, salary);
	            p.setString(12, emp_id);
	        }  
	        p.executeUpdate();
	        String msg = "Employee Info Updated Successfully";
		    RequestDispatcher rd = request.getRequestDispatcher("manage_employees.jsp");
		    request.setAttribute("msg",msg);
		    rd.include(request, response);
		}catch(Exception e) {}
	%>
</body>
</html>