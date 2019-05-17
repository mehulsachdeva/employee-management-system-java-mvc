import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet(urlPatterns = {"/add_table_employee"})
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class add_table_employee extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String emp_fname = request.getParameter("emp_fname");
        String emp_lname = request.getParameter("emp_lname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
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
            
            //Validate First Name
            Pattern name_pattern = Pattern.compile("[a-zA-Z]{2,}");
            Matcher fname_matcher = name_pattern.matcher(emp_fname);
            boolean fname_b = fname_matcher.matches();

            if(emp_fname.length()<2) {
                throw new NewException("First Name Must Have Atleast 2 Characters");
            }
            if(!fname_b) {
                throw new NewException("First Name Can Have Only Characters");
            }
            
            //Validate Last Name
            Matcher lname_matcher = name_pattern.matcher(emp_lname);
            boolean lname_b = lname_matcher.matches();

            if(emp_lname.length()<2) {
                throw new NewException("Last Name Must Have Atleast 2 Characters");
            }
            if(!lname_b) {
                throw new NewException("Last Name Can Have Only Characters");
            }
            
            //Validate Email
            Pattern p_email = Pattern.compile("[a-zA-Z0-9\\.]{3,}@[a-z]{3,10}\\.[a-z]{2,}");
            Matcher m_email = p_email.matcher(emp_email);
            boolean b_email = m_email.matches();
        
            if(emp_email.length()==0) {
                throw new NewException("Email Cannot Be Left Empty");
            }
            if(!b_email) {
                throw new NewException("Invalid Email Provided");
            }
            
            //Validate Contact Number
            Pattern p_contact = Pattern.compile("[1-9][0-9]{9}");
            Matcher m_contact = p_contact.matcher(emp_contact);
            boolean b_contact = m_contact.matches();
            
            if(!b_contact){
                throw new NewException("Invalid Contact Number Provided");
            }
            //Validate Date Of Birth
            Pattern dob_pattern = Pattern.compile("[0-9]{1,2}/[0-9]{1,2}/[1-2][0-9]{3}");
            Matcher dob_matcher = dob_pattern.matcher(emp_dob);
            boolean dob_b = dob_matcher.matches();

            if(emp_dob.length()==0) {
                throw new NewException("Date Of Birth Cannot Be Left Empty");
            }
            if(!dob_b) {
                throw new NewException("Invalid Date Of Birth Provided");
            }

            //Calculate Age From Date Of Birth and Validate Age
            String[] arr = emp_dob.split("/");
            int day = Integer.parseInt(arr[0]);
            int month = Integer.parseInt(arr[1]);
            int year = Integer.parseInt(arr[2]);

            LocalDate now = LocalDate.now(); //gets localDate

            LocalDate given_dob = LocalDate.of(year, month, day); 
            Period diff = Period.between(given_dob, now); //difference between the dates is calculated

            int age = diff.getYears();

            if(age<18 || age>60) {
                throw new NewException("Sorry, You Must Be Between 18 to 60 Years Old");
            }
            
            //Validate Date of Joining
            String[] array = emp_doj.split("/");
            int joined_day = Integer.parseInt(array[0]);
            int joined_month = Integer.parseInt(array[1]);
            int joined_year = Integer.parseInt(array[2]);

            LocalDate given_doj = LocalDate.of(joined_year, joined_month, joined_day); 
            Period difference = Period.between(now, given_doj); //difference between the dates is calculated

            if(emp_doj.length()==0) {
                throw new NewException("Date Of Joining Cannot Be Left Empty");
            }
            //Throw Error For Past Date Of Joining Dates
            if(difference.getYears()<0 || difference.getDays()<0 || difference.getMonths()<0) {
                throw new NewException("Date Of Joining Not Applicable");
            }
            
            //Validate Address Field
            if(address.length()==0){
                throw new NewException("Address Field Cannot Be Empty");
            }

            //Validate department
            if(department.length()==0){
                throw new NewException("Department Field Cannot Be Left Empty");
            }
            if(department.length()<2){
                throw new NewException("Department Field Must Contain Atleast 2 Characters");
            }
            Pattern sal_pattern = Pattern.compile("[0-9]{1,}");
            Matcher sal_matcher = sal_pattern.matcher(salary);
            boolean sal_b = sal_matcher.matches();
            //Validate Salary
            if(!sal_b){
                throw new NewException("Invalid Salary Entered");
            }else{
//                response.sendRedirect("home.jsp");
            	Class.forName("com.mysql.jdbc.Driver");
    			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";
                Connection con = DriverManager.getConnection(url);
                PreparedStatement p = con.prepareStatement("insert into employee (firstname,lastname,username,password,gender,dob,email,contact,doj,address,department,designation,salary,photo) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                Part filePart = request.getPart("passport_photo");
                InputStream inputStream = filePart.getInputStream();
                p.setString(1, emp_fname);
                p.setString(2, emp_lname);
                p.setString(3, username);
                p.setString(4, password);
                p.setString(5, gender);
                p.setString(6, emp_dob);
                p.setString(7, emp_email);
                p.setString(8, emp_contact);
                p.setString(9, emp_doj);
                p.setString(10, address);
                p.setString(11, department);
                p.setString(12, designation);
                p.setString(13, salary);
                p.setBlob(14, inputStream);
                p.executeUpdate();
                String msg = "Employee Added Successfully";
//        	    RequestDispatcher rd = request.getRequestDispatcher("add_employee.jsp");
//        	    request.setAttribute("msg",msg);
//        	    rd.include(request, response);
                response.sendRedirect("add_employee.jsp?msg=" + msg);
            }
        }catch(NewException e) {
//            RequestDispatcher rd_err = request.getRequestDispatcher("add_employee.jsp");
//            request.setAttribute("error",String.valueOf(e));
//            rd_err.include(request, response);
        	response.sendRedirect("add_employee.jsp?error=" + String.valueOf(e));
        }catch(ClassNotFoundException e){
            out.println(e);
        }catch(SQLException e){
            out.println(e);
        }
    }
}