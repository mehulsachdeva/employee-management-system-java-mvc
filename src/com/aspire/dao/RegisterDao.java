package com.aspire.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.aspire.bean.RegisterBean;
import com.aspire.util.DBConnection;
import com.aspire.util.EncryptPassword;

public class RegisterDao {
	public String registerUser(RegisterBean registerBean) {
		
		final String secretKey = "secretkey";
		
		String fullname = registerBean.getFullname();
		String username = registerBean.getUsername();
		String pass = registerBean.getPassword();
		String email = registerBean.getEmail();
		String contact = registerBean.getContact();
		
		EncryptPassword encryptPassword = new EncryptPassword();
        String password = encryptPassword.encrypt(pass, secretKey);
		
		Connection con = null;
		PreparedStatement p = null;
		
		try {
			con = DBConnection.createConnection();
			
			p = con.prepareStatement("insert into admin values(?,?,?,?,?)");
			p.setString(1, fullname);
			p.setString(2, username);
			p.setString(3, password);
			p.setString(4, email);
			p.setString(5, contact);
			p.executeUpdate();
			
			return "Registered Successfully";
		}catch(Exception e) {}
		return "Error";
	}
}
