package com.aspire.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aspire.bean.AdminBean;
import com.aspire.bean.EmployeeBean;
import com.aspire.bean.LoginBean;
import com.aspire.dao.LoginDao;
import com.aspire.service.UserService;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	public LoginServlet() {}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		LoginBean loginBean = new LoginBean();
		
		loginBean.setUsername(username);
		loginBean.setPassword(password);
		
		UserService userService = new UserService();
		
		String login_msg = userService.loginValidation(loginBean);
		
		if(login_msg.equals("Success")) {
			
			LoginDao loginDao = new LoginDao();
		
			try{
				EmployeeBean employeeBean = loginDao.authenticateEmployee(loginBean);
				AdminBean adminBean = loginDao.authenticateAdmin(loginBean);
				
				if(employeeBean != null && adminBean == null) {
					HttpSession session = request.getSession();  
		    		//session.setAttribute("login_username", userBean.getUsername());
		    		session.setAttribute("employeeBean", employeeBean);
		    		response.sendRedirect("employee/home_employee.jsp");
				}
				else if(adminBean != null && employeeBean == null) {
					HttpSession session = request.getSession();  
		    		//session.setAttribute("login_username", userBean.getUsername());
		    		session.setAttribute("adminBean", adminBean);
		    		response.sendRedirect("admin/home_admin.jsp");
				}
				else {
					String msg = "Invalid Credentials";
					response.sendRedirect("login.jsp?msg=" + msg);
				}
				
			}catch(Exception e) {}
			
		}else {
			response.sendRedirect("login.jsp?msg=" + login_msg);
		}
	}

}
