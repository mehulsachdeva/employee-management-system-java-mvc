import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/logoutServlet"})
public class logoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String logout_msg = "Logout Successfully";
        //RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        HttpSession session = request.getSession();  
        session.invalidate();
        //request.setAttribute("logout",logout_msg);
        //rd.forward(request, response);  
        response.sendRedirect("login.jsp?logout=" + logout_msg);
    }
    
}
