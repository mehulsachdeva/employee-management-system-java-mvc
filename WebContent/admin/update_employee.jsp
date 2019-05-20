<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.Base64"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/add_employee.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<body>
	<%
		String[] genders = {"Male","Female","Others"};
		String[] designations = {"Employees, Freelancers, Temporary Employees or Part-Time Employees","Developer","Senior Developer","Junior Developer","Manager","Middle Manager of people or a function","Director","Assistant Director","Senior Director"};
		String id = request.getParameter("id");
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
	    Connection con = DriverManager.getConnection(url);
	    PreparedStatement p = con.prepareStatement("select * from employee where emp_id=?");
	    p.setString(1, id);
	   	ResultSet result = p.executeQuery();
	   	if(result.next()){
	%>
   	<form action="../update_employee" method="POST" enctype="multipart/form-data">    
   	     
   	    <label for="username">Employee ID</label>
        <input type="text" class="fields" value="<%= result.getString(1)%>" name="emp_id" placeholder="Employee ID" readonly="readonly" />
        
        <label for="emp_name">Employee Name</label><br>
        <input type="text" name="emp_fname" value="<%= result.getString(2)%>" class="fname" placeholder="First Name" />
        <input type="text" name="emp_lname" value="<%= result.getString(3)%>" class="lname" placeholder="Last Name" />
        
        <label for="username">Username</label>
        <input type="text" class="fields" value="<%= result.getString(4)%>" name="username" placeholder="Username" readonly="readonly" />
        
        <label for="emp_id">Password</label>
        <input type="text" class="fields" value="<%= result.getString(5)%>" name="password" placeholder="Password" />
        
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
            <figcaption><input type="file" id="photo" name="passport_photo" /></figcaption>
        </figure>

    	<input type="submit" value="UPDATE" />
    </form>
	<%
	   	}
	%>
	<script type="text/javascript">
		
       function readURL(input) {
           if (input.files && input.files[0]) {
               var reader = new FileReader();

               reader.onload = function(e) {
                 $('#preview_photo').attr('src', e.target.result);
               }

               reader.readAsDataURL(input.files[0]);
             }
       }
       $("#photo").change(function() {
           readURL(this);
       });
     </script>
</body>
</html>