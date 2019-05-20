import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/validate")
public class validate extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
        //PrintWriter out = response.getWriter();
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Pattern p = Pattern.compile("[a-zA-Z0-9\\.]{5,}");
        Matcher m = p.matcher(username);
        boolean b = m.matches();
        
        try{
            if(username.length()==0){
                throw new NewException("Username Cannot Be Left Empty");
            }
            if(username.length()<5){
                throw new NewException("Username Cannot Be Less Than 5 Characters");
            }
            if(!b){
                throw new NewException("Username Can Contain Only Characters, Digits and Dots");
            }
            if(password.length()==0){
                throw new NewException("Password Cannot Be Left Empty");
            }
            if(password.length()<5){
                throw new NewException("Password Cannot Be Less Than 5 Characters");
            }
            else{            	
        		boolean employee_status = false;
        		boolean admin_status = false;
        		
        		Class.forName("com.mysql.jdbc.Driver");
        		String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";
                Connection con = DriverManager.getConnection(url);
                PreparedStatement ps = con.prepareStatement("select username,password from employee where username=? and password=?");
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet result = ps.executeQuery();
                employee_status = result.next();
                
                PreparedStatement pa = con.prepareStatement("select username,password from admin where username=? and password=?");
                pa.setString(1, username);
                pa.setString(2, password);
                ResultSet res = pa.executeQuery();
                admin_status = res.next(); 
                
                if(employee_status) {
                	HttpSession session=request.getSession();  
            		session.setAttribute("login_username",username);
            		response.sendRedirect("employee/home_employee.jsp");
                }
                else if(admin_status) {
            		HttpSession session=request.getSession();  
            		session.setAttribute("login_username",username); 
            		response.sendRedirect("admin/home_admin.jsp");
            	}else {
            		String msg = "Invalid Credentials";
            		response.sendRedirect("login.jsp?invalid=" + msg);
                }
            	
            }
        }catch(Exception e){
        	response.sendRedirect("login.jsp?error=" + String.valueOf(e));
        }
    }
}
