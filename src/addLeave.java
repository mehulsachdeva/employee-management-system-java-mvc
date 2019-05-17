

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addLeave")
public class addLeave extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
        String emp_id = request.getParameter("emp_id");
        String emp_fname = request.getParameter("emp_fname");
        String emp_lname = request.getParameter("emp_lname");
        String from_date = request.getParameter("from_date");
        String to_date = request.getParameter("to_date");
        String reason = request.getParameter("reason");
        String status = request.getParameter("status");
        String email="",contact="",department="",designation="";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);
		    PreparedStatement ps = con.prepareStatement("select email,contact,department,designation from employee where emp_id=?");
		    ps.setString(1, emp_id);
		    ResultSet result = ps.executeQuery();
		    if(result.next()) {
		    	email=result.getString(1);
		    	contact=result.getString(2);
		    	department=result.getString(3);
		    	designation=result.getString(4);
		    }
		    PreparedStatement p = con.prepareStatement("insert into employee_leave values(?,?,?,?,?,?,?,?,?,?,?,?)");
		    p.setString(1, emp_id);
		    p.setString(2, emp_fname);
		    p.setString(3, emp_lname);
		    p.setString(4, email);
		    p.setString(5, contact);
		    p.setString(6, department);
		    p.setString(7, designation);
		    p.setString(8, from_date);
		    p.setString(9, to_date);
		    p.setString(10, status);
		    p.setString(11, reason);
		    p.setString(12, "hi");
		    p.executeUpdate();
		    out.println("Inserted");
		}catch(Exception e) {}
	}

}
