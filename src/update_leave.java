

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class update_leave
 */
@WebServlet(urlPatterns= {"/update_leave"})
public class update_leave extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String emp_id = request.getParameter("emp_id");
	    String from_date = request.getParameter("from_date");
	    String to_date = request.getParameter("to_date");
	    String status = request.getParameter("status");
	    String reason = request.getParameter("reason");
	    String leave_id = request.getParameter("leave");
		try{
			String query = "";
			PreparedStatement p = null;
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);	   
	       	query = "update employee_leave set from_date=?, to_date=?, status=?, reason=? where emp_id=? and leave_id=?";
	       	p = con.prepareStatement(query);
			p.setString(1, from_date);
			p.setString(2, to_date);
			p.setString(3, status);
			p.setString(4, reason);
	       	p.setString(5, emp_id);
	       	p.setString(6, leave_id);
	        p.executeUpdate();
	        String msg = "Leave Updated Successfully";
	        response.sendRedirect("admin/manage_leaves.jsp?msg=" + msg);
		}catch(Exception e) {}
	}

}
