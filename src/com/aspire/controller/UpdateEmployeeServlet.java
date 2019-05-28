package com.aspire.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.aspire.bean.EmployeeBean;
import com.aspire.dao.ManageDao;
import com.aspire.util.EncryptPassword;


@WebServlet("/UpdateEmployeeServlet")
@MultipartConfig(maxFileSize = 16177215) 
public class UpdateEmployeeServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		final String secretKey = "secretkey";
		String emp_id = request.getParameter("emp_id");
        String emp_fname = request.getParameter("emp_fname");
        String emp_lname = request.getParameter("emp_lname");
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
        
        ManageDao manageDao = new ManageDao();
	    
	    try {
	    	boolean flag = manageDao.storeUpdatedEmployee(employeeBean, emp_id);
	    	if(flag) {
	    		String msg = "Employee Updated Successfully";
	    		response.sendRedirect("admin/manage_employees.jsp?msg=" + msg);
	    	}
	    }catch(Exception e) {
	    	String msg = "Oops...Error In Updating Employee";
    		response.sendRedirect("admin/manage_employees.jsp?msg=" + msg);
	    }
	}

}
