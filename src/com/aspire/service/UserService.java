package com.aspire.service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.aspire.bean.LoginBean;
import com.aspire.bean.RegisterBean;

public class UserService {
	
	public String loginValidation(LoginBean loginBean) {
		
		String username = loginBean.getUsername();
		String password = loginBean.getPassword();
		String msg = null;
		try {
			Pattern p = Pattern.compile("[a-zA-Z0-9\\.]{5,}");
	        Matcher m = p.matcher(username);
	        boolean b = m.matches();
	        
			if(username.length()==0){
                msg = "Username Cannot Be Left Empty";
            }
			else if(username.length()<5){
            	msg = "Username Cannot Be Less Than 5 Characters";
            }
			else if(!b){
                msg = "Username Can Contain Only Characters, Digits and Dots";
            }
			else if(password.length()==0){
                msg = "Password Cannot Be Left Empty";
            }
			else if(password.length()<5){
                msg = "Password Cannot Be Less Than 5 Characters";
            }
			else {
				msg = "Success";
			}
            return msg;
		}catch(Exception e) {
			return "Oops...Error in Login";
		}
	}
	
	public String registerValidation(RegisterBean registerBean) {

		final String fixedaccesskey = "AB1242";
		
		String fullname = registerBean.getFullname();
		String username = registerBean.getUsername();
		String password = registerBean.getPassword();
		String confirm_password = registerBean.getConfirmpassword();
		String email = registerBean.getEmail();
		String contact = registerBean.getContact();
		String accesskey = registerBean.getAccesskey();
		
		String msg = null;
		
		try {
			Pattern p_fullname = Pattern.compile("^[a-zA-Z ]*$");
	        Matcher m_fullname = p_fullname.matcher(fullname);
	        boolean b_fullname = m_fullname.matches();
	        
	        Pattern p_username = Pattern.compile("[a-zA-Z0-9\\.]{5,}");
	        Matcher m_username = p_username.matcher(username);
	        boolean b_username = m_username.matches();
	        
	        Pattern p_email = Pattern.compile("[a-zA-Z0-9\\.]{3,}@[a-z]{3,6}\\.[a-z]{2,3}");
	        Matcher m_email = p_email.matcher(email);
	        boolean b_email = m_email.matches();
	        
	        Pattern p_contact = Pattern.compile("[1-9][0-9]{9}");
	        Matcher m_contact = p_contact.matcher(contact);
	        boolean b_contact = m_contact.matches();
	        
			if(fullname.length()==0) {
        		msg = "Name Cannot Be Left Empty";
        	}
			else if(!b_fullname) {
        		msg = "Name Must Consist Of Characters Only.";
        	}
			else if(username.length()==0){
                msg = "Username Cannot Be Left Empty";
            }
			else if(username.length()<5){
                msg = "Username Cannot Be Less Than 5 Characters";
            }
			else if(!b_username){
               	msg = "Username Can Contain Only Characters, Digits and Dots";
            }
			else if(password.length()==0){
                msg = "Password Cannot Be Left Empty";
            }
			else if(password.length()<5){
                msg = "Password Cannot Be Less Than 5 Characters";
            }
			else if(!confirm_password.equals(password)){
                msg = "Confirm Password Does Not Match With Password";
            }
			else if(!b_email){
                msg = "Invalid Email Provided";
            }
			else if(!b_contact){
                msg = "Invalid Contact Number Provided";
            }
			else if(!accesskey.equals(fixedaccesskey)) {
				msg = "Access Key Not Valid";
			}
			else {
				msg = "Success";
			}
			return msg;
		}catch(Exception e) {
			return "Oops...Error In Registration";
		}
	}
}
