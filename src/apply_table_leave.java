

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns= {"/apply_table_leave"})
public class apply_table_leave extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//session
		HttpSession session = request.getSession();  
		String username = (String)session.getAttribute("login_username");
		
		String emp_id = "";
	    String from_date = request.getParameter("from_date");
	    String to_date = request.getParameter("to_date");
	    String reason = request.getParameter("reason");
	    String status = "Pending";
	    
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);
		    
		    PreparedStatement pi = con.prepareStatement("select emp_id from employee where username=?");
	        pi.setString(1, username);
	        ResultSet res = pi.executeQuery();
	        if(res.next()){
	        	emp_id = res.getString(1);
	        }
	        
	        PreparedStatement ps = con.prepareStatement("select firstname,lastname,email,contact,department,designation from employee where emp_id=?");
		    ps.setString(1, emp_id);
		    ResultSet result = ps.executeQuery();
		    if(result.next()) {
		    	PreparedStatement p = con.prepareStatement("insert into employee_leave(emp_id,firstname,lastname,email,contact,department,designation,from_date,to_date,status,reason) values (?,?,?,?,?,?,?,?,?,?,?)");
			    String firstname = result.getString(1);
			    String lastname = result.getString(2);
			    String email = result.getString(3);
			    String contact = result.getString(4);
			    String department = result.getString(5);
			    String designation = result.getString(6);
		    	p.setString(1, emp_id);
			    p.setString(2, firstname);
			    p.setString(3, lastname);
			    p.setString(4, email);
			    p.setString(5, contact);
			    p.setString(6, department);
			    p.setString(7, designation);
			    p.setString(8, from_date);
			    p.setString(9, to_date);
			    p.setString(10, status);
			    p.setString(11, reason);
			    p.executeUpdate();
			    String msg = "Leave Applied Successfully";
			    response.sendRedirect("employee/apply_leave.jsp?msg=" + msg);  
		    }else{
		    	String msg = "No Employee Found";
		    	response.sendRedirect("employee/apply_leave.jsp?msg=" + msg);
		    }
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
