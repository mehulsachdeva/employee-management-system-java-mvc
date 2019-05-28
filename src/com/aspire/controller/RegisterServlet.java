package com.aspire.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aspire.bean.RegisterBean;
import com.aspire.dao.RegisterDao;
import com.aspire.service.UserService;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String accesskey = request.getParameter("access_key");
        
        RegisterBean registerBean = new RegisterBean();
        
        registerBean.setFullname(fullname);
        registerBean.setUsername(username);
        registerBean.setPassword(password);
        registerBean.setConfirmpassword(confirmpassword);
        registerBean.setEmail(email);
        registerBean.setContact(contact);
        registerBean.setAccesskey(accesskey);
        
        UserService userService = new UserService();
        
        String register_msg = userService.registerValidation(registerBean);
        
        if(register_msg.equals("Success")) {
        
	        RegisterDao registerDao = new RegisterDao();
	        
	        String status = registerDao.registerUser(registerBean);
	        
	        if(status.equals("Error")) {
	        	response.sendRedirect("register.jsp?msg=" + status);
	        }else {
	        	response.sendRedirect("login.jsp?msg=" + status);
	        }
	        
        }else {
        	response.sendRedirect("register.jsp?msg=" + register_msg);
        }
	}

}
