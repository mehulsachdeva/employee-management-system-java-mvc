package com.aspire.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.aspire.bean.EmployeeBean;
import com.aspire.dao.EmployeeDao;
import com.aspire.service.UserService;
import com.aspire.util.EncryptPassword;


@WebServlet("/EmployeeServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class EmployeeServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final String secretKey = "secretkey";
		String emp_fname = request.getParameter("emp_fname");
        String emp_lname = request.getParameter("emp_lname");
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        
        EncryptPassword encryptPassword = new EncryptPassword();
        String password = encryptPassword.encrypt(pass, secretKey);
        
        String gender = request.getParameter("gender");
        String emp_dob = request.getParameter("emp_dob");
        String emp_email = request.getParameter("emp_email");
        String emp_contact = request.getParameter("emp_contact");
        String address = request.getParameter("emp_address");
        String department = request.getParameter("emp_department");
        String designation = request.getParameter("emp_designation");
        String emp_doj = request.getParameter("emp_doj");
        String salary = request.getParameter("emp_salary");
        InputStream inputStream = null;
        ByteArrayOutputStream os = null;
        byte[] buffer = null, photo = null;
        Part filePart = request.getPart("passport_photo");
        if(filePart!=null) {
        	inputStream = filePart.getInputStream();
	        os = new ByteArrayOutputStream();
			buffer = new byte[1024];
			int len;
			while ((len = inputStream.read(buffer)) != -1) {
				os.write(buffer, 0, len);
			}
			photo = os.toByteArray();
        }
		
		EmployeeBean employeeBean = new EmployeeBean();
		
		employeeBean.setFirstname(emp_fname);
		employeeBean.setLastname(emp_lname);
        employeeBean.setUsername(username);
        employeeBean.setPassword(password);
        employeeBean.setGender(gender);
        employeeBean.setDob(emp_dob);
        employeeBean.setEmail(emp_email);
        employeeBean.setContact(emp_contact);
        employeeBean.setAddress(address);
        employeeBean.setDepartment(department);
        employeeBean.setDesignation(designation);
        employeeBean.setDoj(emp_doj);
        employeeBean.setSalary(salary);
        employeeBean.setPhoto(photo);
        
        EmployeeDao employeeDao = new EmployeeDao();
        boolean flag = false;
        try {
        	flag = employeeDao.addEmployee(employeeBean);
        	if(flag) {
        		String msg = "Employee Added Successfully";
        		response.sendRedirect("admin/add_employee.jsp?msg=" + msg);
        	}else {
        		String msg = "Oops...Error In Adding Employee";
        		response.sendRedirect("admin/add_employee.jsp?msg=" + msg);
        	}
        }catch(Exception e) {}
	}
}
