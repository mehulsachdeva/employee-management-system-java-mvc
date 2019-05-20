

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(urlPatterns= {"/update_employee"})
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB

public class update_employee extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String emp_id = request.getParameter("emp_id");
        String emp_fname = request.getParameter("emp_fname");
        String emp_lname = request.getParameter("emp_lname");
        String gender = request.getParameter("gender");
        String emp_dob = request.getParameter("emp_dob");
        String emp_email = request.getParameter("emp_email");
        String emp_contact = request.getParameter("emp_contact");
        String address = request.getParameter("emp_address");
        String department = request.getParameter("emp_department");
        String designation = request.getParameter("emp_designation");
        String emp_doj = request.getParameter("emp_doj");
        String salary = request.getParameter("emp_salary");
		try{
			String query = "";
			PreparedStatement p = null;
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
		    Connection con = DriverManager.getConnection(url);
		    Part filePart = request.getPart("passport_photo");
		    InputStream inputStream = filePart.getInputStream();
            if(filePart.getSize()!=0) {
            	query = "update employee set firstname=?, lastname=?, gender=?, dob=?, email=?, contact=?, doj=?, address=?, department=?, designation=?, salary=?, photo=? where emp_id=?";
            	p = con.prepareStatement(query);
            	p.setString(1, emp_fname);
                p.setString(2, emp_lname);
                p.setString(3, gender);
                p.setString(4, emp_dob);
                p.setString(5, emp_email);
                p.setString(6, emp_contact);
                p.setString(7, emp_doj);
                p.setString(8, address);
                p.setString(9, department);
                p.setString(10, designation);
                p.setString(11, salary);
            	p.setBlob(12, inputStream);
            	p.setString(13, emp_id);
            }else {
            	query = "update employee set firstname=?, lastname=?, gender=?, dob=?, email=?, contact=?, doj=?, address=?, department=?, designation=?, salary=? where emp_id=?";
            	p = con.prepareStatement(query);
            	p.setString(1, emp_fname);
                p.setString(2, emp_lname);
                p.setString(3, gender);
                p.setString(4, emp_dob);
                p.setString(5, emp_email);
                p.setString(6, emp_contact);
                p.setString(7, emp_doj);
                p.setString(8, address);
                p.setString(9, department);
                p.setString(10, designation);
                p.setString(11, salary);
                p.setString(12, emp_id);
            }  
            p.executeUpdate();
            String msg = "Employee Info Updated Successfully";
            response.sendRedirect("admin/manage_employees.jsp?msg=" + msg);
		}catch(Exception e) {}
	}

}
