package com.aspire.dao;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.aspire.bean.EmployeeBean;
import com.aspire.util.DBConnection;

public class EmployeeDao {
public boolean addEmployee(EmployeeBean employeeBean) {
		
		String emp_fname = employeeBean.getFirstname();
        String emp_lname = employeeBean.getLastname();
        String username = employeeBean.getUsername();
        String password = employeeBean.getPassword();
        String gender = employeeBean.getGender();
        String emp_dob = employeeBean.getDob();
        String emp_email = employeeBean.getEmail();
        String emp_contact = employeeBean.getContact();
        String address = employeeBean.getAddress();
        String department = employeeBean.getDepartment();
        String designation = employeeBean.getDesignation();
        String emp_doj = employeeBean.getDoj();
        String salary = employeeBean.getSalary();
        byte[] photo = employeeBean.getPhoto();
        
        InputStream inputStream = new ByteArrayInputStream(photo); 
        
        String[] array = emp_doj.split("/");
        int joined_year = Integer.parseInt(array[2]);
        
        Connection con = null;
        PreparedStatement p = null, ph = null;
        try {
        	con = DBConnection.createConnection();
        	p = con.prepareStatement("insert into employee (firstname,lastname,username,password,gender,dob,email,contact,doj,address,department,designation,salary,photo) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
        	
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
            
            ph = con.prepareStatement("insert into history(firstname, lastname, email, doj, department, designation, year) values (?,?,?,?,?,?,?)");
            ph.setString(1, emp_fname);
            ph.setString(2, emp_lname);
            ph.setString(3, emp_email);
            ph.setString(4, emp_doj);
            ph.setString(5, department);
            ph.setString(6, designation);
            ph.setString(7, String.valueOf(joined_year));
            ph.executeUpdate();
            
            return true;
        }catch(Exception e) {}
        return false;
	}
}
