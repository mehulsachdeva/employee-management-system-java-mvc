<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.aspire.bean.EmployeeBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EMS | Employee</title>
<link rel="stylesheet" href="../css/add_employee.css" type="text/css" />
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../css/main.css" type="text/css" />
<link rel="stylesheet" href="../css/main1.css" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/skel.min.js"></script>
<script type="text/javascript" src="../js/jquery.scrollex.min.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<script type="text/javascript" src="../js/main.js"></script>					
</head>
<body>
	<% 
		EmployeeBean employeeBean = (EmployeeBean) session.getAttribute("employeeBean");
		String username = null;
		if(employeeBean == null){
			response.sendRedirect("../login.jsp");
		}else{
			username = employeeBean.getUsername();
    %>
    <nav>
   	<div id="logo">Employee Management System</div>

	<label for="drop" class="toggle">Menu</label>
	<input type="checkbox" id="drop" />
	    <ul class="menu">
	        <li><a href="../employee/home_employee.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
	
	        <li>
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-1"/>
		        <ul>
		            <li><a href="../employee/view_tasks.jsp">View Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="../employee/apply_leave.jsp">Apply Leaves</a></li>
		            <li><a href="../employee/view_leaves.jsp">View Leaves</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="attendance" class="toggle">Attendance</label>
		        <a><i class="fa fa-user-plus">&nbsp;Attendance</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="../employee/view_attendance.jsp">View Attendance</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="report" class="toggle">Report</label>
		        <a href="../employee/view_report.jsp"><i class="fa fa-line-chart">&nbsp;Report</i></a>
		        <input type="checkbox" id="drop-4"/>

	        </li>
	        
	        <li>
		        <label for="details" class="toggle">View Details</label>
		        <a href="../employee/view_details.jsp"><i class="fa fa-line-chart">&nbsp;View Details</i></a>
		        <input type="checkbox" id="drop-5"/>

	        </li>
	        
	        <li>
		        <label for="welcome" class="toggle">Welcome <%= username%></label>
		        <a><i class="fa fa-info-circle">&nbsp;Welcome <%= username%></i></a>
		        <input type="checkbox" id="drop-6"/>
		        <ul>
		            <li><a href="../logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
	
	<section class="banner full">
		<article>
			<img src="../images/background_slide02.jpg" alt="" />
			<div class="inner">
				<header>
					<h2>Positive Attitutde</h2><span>Creating a good environment</span>
				</header>
			</div>
		</article>
		<article>
			<img src="../images/background_slide01.jpg" alt="" />
			<div class="inner">
				<header>
					<h2>Self Motivated</h2><span>Working effectively with little direction</span>
				</header>
			</div>
		</article>
		<article>
			<img src="../images/background_slide03.jpg"  alt="" />
			<div class="inner">
				<header>
					<h2>Team Oriented</h2><span>Making the most out of collaboration</span>
				</header>
			</div>
		</article>
		<article>
			<img src="../images/background_slide04.jpg"  alt="" />
			<div class="inner">
				<header>
					<h2>Strong work ethic</h2><span>Setting and acheiving goals </span>
				</header>
			</div>
		</article>	
	</section>
			
	<section class="banner full">
	<article>
	<img src="../images/background_slide04.jpg"  alt="" />
		<div class="inner"><header>
		<div>
		  <div class="hoc container clear"> 
		      <h2 class="heading font-x2">About Creators</h2>
		    </div>
		    <ul class="nospace group team">
		    <li class="one_third first">
		        <figure>
		          <figcaption><strong>Mehul Sachdeva</strong> <em>Developer</em><em>VIT University</em></figcaption>
		        </figure>
		      </li>
		      <li class="one_third">
		        <figure>
		          <figcaption><strong>Aadarsh Kumar</strong> <em>Developer</em><em>VIT University</em></figcaption>
		        </figure>
		      </li>
		      <li class="one_third">
		        <figure>
		          <figcaption><strong>Abhinav Raj</strong> <em>Developer</em><em>VIT University</em></figcaption>
		        </figure>
		      </li>
		    </ul>
		    </div>
		    </header>
		  </div>

	</article>
	</section>
	<footer>
		<div class="copyright">
			&copy; All rights reserved.
		</div>
	</footer>
	<%
		}
	%>
</body>
</html>