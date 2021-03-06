<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Authentication</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/register.css" />
        <script src="js/validation.js"></script>
        <style>
        body{
        	overflow: hidden;
        }
		#title{
			color: white;
			padding: 10px 10px;
			font-size: 45px;
			position: relative;
			top:35%;
			left: 5%;
		}
		.sub-container{
			position: fixed;
    		right: 6%;
			top: 8%;
		}
        </style>
    </head>
    <body>
    <div class="container">
    	<div id="title">
        	<b>Employee Management System</b>
        </div>
        <div class="sub-container">
            <form name="myform" action="RegisterServlet" method="POST">
                <center><h3>Registration Form</h3></center>
                
                <center><span><%= (request.getParameter("msg") == null)? "": request.getParameter("msg")%></span></center>
                <label for="fullname">Full Name</label>
                <input type="text" name="fullname" placeholder="Full Name" required/><span id="a"></span>
				<br>
				
                <label for="username">Username</label>
                <input type="text" name="username" placeholder="Username" required/><span id="b"></span>
				<br>
                
                <label for="password">Password</label>
                <input type="password" name="password" placeholder="Password" required/><span id="c"></span>
				<br>

                <label for="confirm_password">Confirm Password</label> 
                <input type="password" name="confirmpassword" placeholder="Confirm Password" required/><span id="d"></span>
				<br>

                <label for="email">Email</label>
                <input type="email" name="email" id="email" placeholder="Email" required/>
				<br>
				
                <label for="contact">Contact Number</label>
                <input type="text" name="contact" placeholder="Contact No." required/><span id="e"></span>
				<br>

				<label for="username">Access Key</label>
                <input type="text" name="access_key" placeholder="Access Key" required/>
                
                <input type="submit" value="Register" />

            </form>
        </div>
    </div>
    </body>
</html>