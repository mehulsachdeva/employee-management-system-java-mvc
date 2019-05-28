<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.aspire.dao.ManageDao" %>
<%@ page import="com.aspire.util.EncryptPassword"%>
<%@ page import="java.util.Base64"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Employee</title>
<link rel="stylesheet" type="text/css" href="../css/add_employee.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<body>

	<%
		String[] genders = {"Male","Female","Others"};
		String[] designations = {"Interns, Part-Time Employees or Temporary Employees","Employees","Developer","Senior Developer","Junior Developer","Manager","Middle Manager of People or a Function","Director","Assistant Director","Senior Director"};
		String id = request.getParameter("id");
		
		ResultSet result = null;
		ManageDao manageDao = new ManageDao();
		try{
			result = manageDao.getCurrentEmployee(id);
		}catch(Exception e){}
		if(result != null){
	   		if(result.next()){
	   			final String secretKey = "secretkey";
	   			EncryptPassword encryptPassword = new EncryptPassword();
	   	        String password = encryptPassword.decrypt(result.getString(5), secretKey);
	%>
	
   	<form action="../UpdateEmployeeServlet" method="POST" enctype="multipart/form-data">    
   	     
   	    <label for="username">Employee ID</label>
        <input type="text" class="fields" value="<%= result.getString(1)%>" name="emp_id" placeholder="Employee ID" readonly="readonly" />
        
        <label for="emp_name">Employee Name</label><br>
        <input type="text" name="emp_fname" value="<%= result.getString(2)%>" class="fname" placeholder="First Name" />
        <input type="text" name="emp_lname" value="<%= result.getString(3)%>" class="lname" placeholder="Last Name" />
        
        <label for="username">Username</label>
        <input type="text" class="fields" value="<%= result.getString(4)%>" name="username" placeholder="Username" readonly="readonly" />
        
        <label for="emp_id">Password</label>
        <input type="text" class="fields" value="<%= password%>" name="password" placeholder="Password" />
        
        <label for="gender">Gender</label>
        <select name="gender">
        
        <%
        	for(String element: genders){
        		if(element.equals(result.getString(6))){
        %>
        
        <option selected="selected"><%= element%></option>
		
		<%
        		}
        		else{
       	%>
       	
       	<option><%= element%></option>
       	
       	<%
        		}
        	}
        %>
        
        </select>
        
        <label for="emp_dob">Date Of Birth</label>
        <input type="text" class="fields" value="<%= result.getString(7)%>" name="emp_dob" placeholder="DD/MM/YYYY" />
        
        <label for="emp_email">Email</label>
        <input type="text" class="fields" value="<%= result.getString(8)%>" name="emp_email" placeholder="Email" />
        
        <label for="emp_contact">Contact Number</label>
        <input type="text" class="fields" value="<%= result.getString(9)%>" name="emp_contact" placeholder="Contact Number" />
        
        <label for="emp_doj">Date Of Joining</label>
        <input type="text" class="fields" value="<%= result.getString(10)%>" name="emp_doj" placeholder="DD/MM/YYYY" />
        
        <label for="emp_address">Address</label>
        <input type="text" class="fields" value="<%= result.getString(11)%>" name="emp_address" placeholder="Address" />
        
        <label for="emp_department">Department</label>
        <input type="text" class="fields" value="<%= result.getString(12)%>" name="emp_department" placeholder="Department/Division"/>
        
        <label for="emp_designation">Designation</label>
        <select name="emp_designation">
        
        <%
        	for(String element: designations){
        		if(element.equals(result.getString(13))){
        %>
        
        <option selected="selected"><%= element%></option>
		
		<%
        		}
        		else{
       	%>
       	
       	<option><%= element%></option>
       	
       	<%
        		}
        	}
        %>
        
        </select>
        
        <label for="emp_salary">Salary</label>
        <input type="text" class="fields" value="<%= result.getString(14)%>" name="emp_salary" placeholder="Salary" value="0"/>
      	
      	<%
	      	Blob image = result.getBlob(15);
	        byte[] imgData = image.getBytes(1,(int)image.length());
	        String imgDataBase64=new String(Base64.getEncoder().encode(imgData));
      	%>
        
        <label for="upload">Upload Employee Passport Size Photo</label><br>
        <figure>
            <img id="preview_photo" src="data:image/gif;base64,<%= imgDataBase64 %>" width="140" height="150"/>
            <br><figcaption><input type="file" id="photo" name="passport_photo" /></figcaption>
        </figure>

    	<input type="submit" value="UPDATE" />
    </form>
    
	<%
	   		}
		}
	%>
	<script src="../js/profile_previewer.js" type="text/javascript"></script>
</body>
</html>