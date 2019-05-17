import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/search"})
public class search extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String query = request.getParameter("search_query");
        RequestDispatcher rd_search = request.getRequestDispatcher("search.jsp");
        try{
            String sql_search_query = "";
            PreparedStatement p;
            Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=mehul&password=mehul";	
            Connection con = DriverManager.getConnection(url);
            if(query.equals("") || query.equals("All") || query.equals("all")){
                sql_search_query = "select * from employee";
                p = con.prepareStatement(sql_search_query);
            }else{
                sql_search_query = "select * from employee where emp_id LIKE ? or firstname LIKE ? or lastname LIKE ? or gender LIKE ? or department LIKE ? or designation LIKE ? or skills LIKE ? or email LIKE ? or contact LIKE ? or dob LIKE ? or doj LIKE ?";
                p = con.prepareStatement(sql_search_query);
                p.setString(1, "%" + query + "%");
                p.setString(2, "%" + query + "%");
                p.setString(3, "%" + query + "%");
                p.setString(4, "%" + query + "%");
                p.setString(5, "%" + query + "%");
                p.setString(6, "%" + query + "%");
                p.setString(7, "%" + query + "%");
                p.setString(8, "%" + query + "%");
                p.setString(9, "%" + query + "%");
                p.setString(10, "%" + query + "%");
                p.setString(11, "%" + query + "%");
            }
            ResultSet result = p.executeQuery();
//            request.setAttribute("result_search",result);
//            rd_search.include(request, response);
        }catch(ClassNotFoundException e){
            out.println(e);
        }catch(SQLException e){
            out.println(e);
        }
    }
}
