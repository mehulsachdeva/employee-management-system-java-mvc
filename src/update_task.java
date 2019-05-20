

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns= {"/update_task"})
public class update_task extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
	        response.sendRedirect("admin/manage_tasks.jsp?msg=" + msg);
		}catch(Exception e) {}
	}

}
