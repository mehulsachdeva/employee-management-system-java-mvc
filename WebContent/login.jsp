<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Authentication</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/login.css" />
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
        </style>
    </head>
    
    <script type="text/javascript">
	    history.pushState(null, null, location.href);
	    window.onpopstate = function () {
	        history.go(1);
	    };
    </script>
    
    <body>
        <div class="container">
        	<div id="title">
            	<b>Employee Management System</b>
            </div>
            <div class="sub-container">
                <form action="LoginServlet" method="POST">
                    <center><h3>Login Form</h3></center>
                    <center><span><%= (request.getParameter("msg") == null) ? "": request.getParameter("msg")%></span></center>
                       
                    <label for="username">Username</label>
                    <input type="text" name="username" placeholder="Username"/>
                    <label for="password">Password</label>
                    <input type="password" name="password" placeholder="Password"/>
                    <input type="submit" value="Submit" />
                </form>
                <center><a href="register.jsp">Not a Member?Register Here</a></center>
                    <%
                         String msg = request.getParameter("invalid");
                         if(msg!=null){
                    %>
                <center><span><%=msg%><span></center>
                    <%
                         }
                    %>
            </div>     
        </div>
    </body>
</html>
