<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Authentication</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="register.css" />
        <script src="validation.js"></script>
    </head>
    <body>
    <div class="container">
        <div class="sub-container">
            <form name="myform" action="registerValidate" method="POST" onsubmit="return validate()">
                <center><h3>Registration Form</h3></center>
                <%
                    String err = (String)request.getAttribute("error");
                    if(err!=null){
                %>
                <center><span><%=err%></span></center>
                <%
                    }else{}
                %>
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
                <input type="password" name="confirm_password" placeholder="Confirm Password" required/><span id="d"></span>
				<br>

                <label for="email">Email</label>
                <input type="email" name="email" id="email" placeholder="Email" required/>
				<br>
				
                <label for="contact">Contact Number</label>
                <input type="text" name="contact" placeholder="Contact No." required/><span id="e"></span>
				<br>

                <input type="submit" value="Register" />

            </form>
        </div>
    </div>
    </body>
</html>