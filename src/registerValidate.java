import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

class MyException extends Exception{
    String d;
    MyException(String d){
        this.d=d;
    }
    public String toString(){
        return d;
    }
}

@WebServlet(urlPatterns = {"/registerValidate"})
public class registerValidate extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        
        Pattern p_fullname = Pattern.compile("^[a-zA-Z ]*$");
        Matcher m_fullname = p_fullname.matcher(fullname);
        boolean b_fullname = m_fullname.matches();
        
        Pattern p_username = Pattern.compile("[a-zA-Z0-9\\.]{5,}");
        Matcher m_username = p_username.matcher(username);
        boolean b_username = m_username.matches();
        
        Pattern p_email = Pattern.compile("[a-zA-Z0-9\\.]{3,}@[a-z]{3,6}\\.[a-z]{2,3}");
        Matcher m_email = p_email.matcher(email);
        boolean b_email = m_email.matches();
        
        Pattern p_contact = Pattern.compile("[1-9][0-9]{9}");
        Matcher m_contact = p_contact.matcher(contact);
        boolean b_contact = m_contact.matches();
        
        try{
        	if(fullname.length()==0) {
        		throw new MyException("Name Cannot Be Left Empty");
        	}
        	if(!b_fullname) {
        		throw new MyException("Name Must Consist Of Characters Only.");
        	}
            if(username.length()==0){
                throw new MyException("Username Cannot Be Left Empty");
            }
            if(username.length()<5){
                throw new MyException("Username Cannot Be Less Than 5 Characters");
            }
            if(!b_username){
                throw new MyException("Username Can Contain Only Characters, Digits and Dots");
            }
            if(password.length()==0){
                throw new MyException("Password Cannot Be Left Empty");
            }
            if(password.length()<5){
                throw new MyException("Password Cannot Be Less Than 5 Characters");
            }
            if(!confirm_password.equals(password)){
                throw new MyException("Confirm Password Does Not Match With Password");
            }
            if(!b_email){
                throw new MyException("Invalid Email Provided");
            }
            if(!b_contact){
                throw new MyException("Invalid Contact Number Provided");
            }else{   
                Class.forName("com.mysql.jdbc.Driver");
    			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";
                Connection con = DriverManager.getConnection(url);
                PreparedStatement p = con.prepareStatement("insert into admin values(?,?,?,?,?)");
                p.setString(1, fullname);
                p.setString(2, username);
                p.setString(3, password);
                p.setString(4, email);
                p.setString(5, contact);
                p.executeUpdate();
//                RequestDispatcher rd_register = request.getRequestDispatcher("login.jsp");
//                request.setAttribute("register",msg);
//                rd_register.include(request, response);
                String msg = "Registered Successfully";
                response.sendRedirect("login.jsp?register=" + msg);
            }
        }catch(Exception e){
//            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
//            request.setAttribute("error", String.valueOf(e));
//            rd.include(request, response);
        	response.sendRedirect("register.jsp?error=" + String.valueOf(e));
        }
        
    }
}
