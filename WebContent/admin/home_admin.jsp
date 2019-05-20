<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home| Admin</title>
<link rel="stylesheet" href="../css/navigation.css" type="text/css" />
<link rel="stylesheet" href="../css/add_employee.css" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../css/main.css" type="text/css" />
<link rel="stylesheet" href="../css/main1.css" type="text/css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/skel.min.js"></script>
<script type="text/javascript" src="../js/jquery.scrollex.min.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<script type="text/javascript" src="../js/main.js"></script>					
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<body>
	<% 
            String username = (String)session.getAttribute("login_username");
        %>
        <nav>
        <div id="logo">Employee Management System</div>

	<label for="drop" class="toggle">Menu</label>
	<input type="checkbox" id="drop" />
	    <ul class="menu">
	        <li><a href="../admin/home_admin.jsp"><i class="fa fa-home">&nbsp;Home</i></a></li>
	        <li>
	            <label for="employees" class="toggle">Employees</label>
	            <a><i class="fa fa-user">&nbsp;Employees</i></a>
	            <input type="checkbox" id="drop-1"/>
	            <ul>
	                <li><a href="../admin/add_employee.jsp">Add Employees</a></li>
	                <li><a href="../admin/manage_employees.jsp">Manage Employees</a></li>
	            </ul> 
	        </li>
	
	        <li>
		        <label for="task_manager" class="toggle">Task Manager</label>
		        <a><i class="fa fa-clock-o">&nbsp;Task Manager</i></a>
		        <input type="checkbox" id="drop-2"/>
		        <ul>
		            <li><a href="../admin/add_task.jsp">Add Tasks</a></li>
		            <li><a href="../admin/manage_tasks.jsp">Manage Tasks</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="leaves" class="toggle">Leaves</label>
		        <a><i class="fa fa-child">&nbsp;Leaves</i></a>
		        <input type="checkbox" id="drop-3"/>
		        <ul>
		            <li><a href="../admin/manage_leaves.jsp">Manage Leaves</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="attendance" class="toggle">Attendance</label>
		        <a><i class="fa fa-user-plus">&nbsp;Attendance</i></a>
		        <input type="checkbox" id="drop-5"/>
		        <ul>
		            <li><a href="../admin/add_attendance.jsp">Add Attendance</a></li>
		            <li><a href="../admin/manage_attendance.jsp">Manage Attendance</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="documents" class="toggle">Documents</label>
		        <a><i class="fa fa-book">&nbsp;Documents</i></a>
		        <input type="checkbox" id="drop-6"/>
				 <ul>
		            <li><a href="../admin/get_history.jsp">History</a></li>
		            <li><a href="../admin/get_report.jsp">Report</a></li>
		        </ul>
	        </li>
	        
	        <li>
		        <label for="welcome" class="toggle">Welcome <%= username%></label>
		        <a><i class="fa fa-info-circle">&nbsp;Welcome <%= username%></i></a>
		        <input type="checkbox" id="drop-4"/>
		        <ul>
		            <li><a href="#settings">Settings</a></li>
		            <li><a href="../logoutServlet">Logout</a></li>
		        </ul>
	        </li>
	        
	    </ul>
	</nav>
	<section class="banner full">
				<article>
					<img src="images/slide02.jpg" alt="" />
					<div class="inner">
						<header>
							<h2>Positive Attitutde</h2><span>Creating a good environment</span>
						</header>
					</div>
				</article>
				<article>
					<img src="../images/slide01.jpg" alt="" />
					<div class="inner">
						<header>
							<h2>Self Motivated</h2><span>Working effectively with little direction</span>
						</header>
					</div>
				</article>
				<article>
					<img src="../images/slide03.jpg"  alt="" />
					<div class="inner">
						<header>
							<h2>Team Oriented</h2><span>Making the most out of collaboration</span>
						</header>
					</div>
				</article>
				<article>
					<img src="../images/slide04.jpg"  alt="" />
					<div class="inner">
						<header>
							<h2>Strong work ethic</h2><span>Setting and acheiving goals </span>
						</header>
					</div>
				</article>	
			</section>
			
			<section class="banner full">
			<article>
			<img src="../images/slide04.jpg"  alt="" />
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
					&copy; Untitled. All rights reserved.
				</div>
			</footer>
</body>
</html>