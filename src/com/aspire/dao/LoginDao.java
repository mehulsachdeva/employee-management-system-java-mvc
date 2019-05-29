package com.aspire.dao;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aspire.bean.AdminBean;
import com.aspire.bean.EmployeeBean;
import com.aspire.bean.LoginBean;
import com.aspire.util.DBConnection;
import com.aspire.util.EncryptPassword;

public class LoginDao {
	public EmployeeBean authenticateEmployee(LoginBean loginBean) {
		
		final String secretKey = "secretkey";
		EmployeeBean employeeBean= new EmployeeBean();
		
		String username = loginBean.getUsername();
		String pass = loginBean.getPassword();
		
		EncryptPassword encryptPassword = new EncryptPassword();
        String password = encryptPassword.encrypt(pass, secretKey);

		Connection con = null;
		PreparedStatement pe = null;
		ResultSet result = null;
		boolean employee_status = false;
		
		try {
			con = DBConnection.createConnection();
            
            pe = con.prepareStatement("select * from employee where username=? and password=?");
            pe.setString(1, username);
            pe.setString(2, password);
            result = pe.executeQuery();
            employee_status = result.next();
            
            if(employee_status) {
            	Blob image = result.getBlob(15);
                byte[] imgData = image.getBytes(1,(int)image.length());
                
                employeeBean.setEmp_id(result.getString(1));
                employeeBean.setFirstname(result.getString(2));
                employeeBean.setLastname(result.getString(3));
                employeeBean.setUsername(result.getString(4));
                employeeBean.setPassword(result.getString(5));
                employeeBean.setGender(result.getString(6));
                employeeBean.setDob(result.getString(7));
                employeeBean.setEmail(result.getString(8));
                employeeBean.setContact(result.getString(9));
                employeeBean.setDoj(result.getString(10));
                employeeBean.setAddress(result.getString(11));
                employeeBean.setDepartment(result.getString(12));
                employeeBean.setDesignation(result.getString(13));
                employeeBean.setSalary(result.getString(14));
                employeeBean.setPhoto(imgData);
            	return employeeBean;
            }
		}catch(Exception e) {}
		return null;
	}
	public AdminBean authenticateAdmin(LoginBean loginBean) {
		
		final String secretKey = "secretkey";
		AdminBean adminBean= new AdminBean();
		
		String username = loginBean.getUsername();
		String pass = loginBean.getPassword();
		
		EncryptPassword encryptPassword = new EncryptPassword();
        String password = encryptPassword.encrypt(pass, secretKey);
        
		Connection con = null;
		PreparedStatement pa = null;
		ResultSet res = null;
		boolean admin_status = false;
		
		try {
			con = DBConnection.createConnection();
			
            pa = con.prepareStatement("select * from admin where username=? and password=?");
            pa.setString(1, username);
            pa.setString(2, password);
            res = pa.executeQuery();
            admin_status = res.next(); 
            
            if(admin_status) {
                adminBean.setFullname(res.getString(1));
                adminBean.setUsername(res.getString(2));
                adminBean.setPassword(res.getString(3));
                adminBean.setEmail(res.getString(4));
                adminBean.setContact(res.getString(5));
            	return adminBean;
            }
		}catch(Exception e) {}
		return null;
	}
}
