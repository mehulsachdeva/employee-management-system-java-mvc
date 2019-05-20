<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String color = "";
		String status = "";
		String emp_id = request.getParameter("emp_id");
	    String task_name = request.getParameter("task_name");
	    String skills_req = request.getParameter("skills_req");
	    String start_date = request.getParameter("start_date");
	    String deadline = request.getParameter("deadline");
	    
	    String arr[] = deadline.split("/");
	    int day = Integer.parseInt(arr[0]);
	    int month = Integer.parseInt(arr[1]);
	    int year = Integer.parseInt(arr[2]);
	    
	    String arr_s[] = start_date.split("/");
	    int day_s = Integer.parseInt(arr_s[0]);
	    int month_s = Integer.parseInt(arr_s[1]);
	    int year_s = Integer.parseInt(arr_s[2]);
	      
	    LocalDate start_line = LocalDate.of(year_s, month_s, day_s);
	    LocalDate end_line = LocalDate.of(year, month, day); 
	    LocalDate today = LocalDate.now();
	    Period diff = Period.between(today, start_line);
	    Period difference = Period.between(today, end_line); //difference between the dates is calculated
	    
	    if(diff.getYears()>0 || diff.getDays()>0 || diff.getMonths()>0){
	    	color = "grey";
	    	status = "Inactive";
	    }else{
	    	if(difference.getYears()<0 || difference.getDays()<0 || difference.getMonths()<0) {
	            color = "red";
	            status = "Late";
	        }else{
		    	color = "black";
		    	status = "Active";
		    }
	    }
	     
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";
            Connection con = DriverManager.getConnection(url);
			PreparedStatement ps = con.prepareStatement("select * from employee where emp_id=?");
		    ps.setString(1, emp_id);
		    ResultSet result = ps.executeQuery();
		    if(result.next()) {	
		    	PreparedStatement p = con.prepareStatement("insert into employee_task_tracker(emp_id, task_name, skills_required, start_date, deadline, status) values (?,?,?,?,?,?)");
	            p.setString(1, emp_id);
	            p.setString(2, task_name);
	            p.setString(3, skills_req);
	            p.setString(4, start_date);
	            p.setString(5, deadline);
	            p.setString(6, status);
	            p.executeUpdate();
	            PreparedStatement pcheck = con.prepareStatement("select * from history where emp_id=?");
	            pcheck.setString(1, emp_id);
	            ResultSet r = pcheck.executeQuery();
	            if(r.next()){
	            	Set<String> tasks_names = new HashSet<String>();
	            	Set<String> skills_names = new HashSet<String>();
	            	String tasks = "";
	            	String skills = "";
	            	PreparedStatement pget = con.prepareStatement("select task_name, skills_required from employee_task_tracker where emp_id=?");
	            	pget.setString(1, emp_id);
	            	ResultSet rget = pget.executeQuery();
	            	while(rget.next()){
	            		tasks_names.add(rget.getString(1));
	            		skills_names.add(rget.getString(2));
	            	}
	            	for(String element: tasks_names) {
	            		tasks += element + ",";
	            	}
	            	for(String element: skills_names) {
	            		skills += element + ",";
	            	}
	            	PreparedStatement ph = con.prepareStatement("update history set tasks=?, skills=? where emp_id=?");
	                ph.setString(1, tasks);
	                ph.setString(2, skills);
	                ph.setString(3, emp_id);
	                ph.executeUpdate();
	                String msg = "Task Added Successfully";
		    	    RequestDispatcher rd = request.getRequestDispatcher("add_task.jsp");
		    	    request.setAttribute("msg",msg);
		    	    rd.include(request, response);
	            }
	            
		    }else{
		    	String msg = "No Employee Found";
		    	RequestDispatcher rd = request.getRequestDispatcher("add_task.jsp");
			    request.setAttribute("msg",msg);
			    rd.forward(request, response);
		    }
		}catch(Exception e){}
	%>
</body>
</html>