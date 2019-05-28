package com.aspire.service;

import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.aspire.bean.EmployeeBean;
import com.aspire.bean.LeaveBean;
import com.aspire.bean.LoginBean;
import com.aspire.bean.RegisterBean;
import com.aspire.bean.TaskBean;

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
	
	public String employeeValidation(EmployeeBean employeeBean) {
		
		String emp_fname = employeeBean.getFirstname();
        String emp_lname = employeeBean.getLastname();
        String emp_dob = employeeBean.getDob();
        String emp_email = employeeBean.getEmail();
        String emp_contact = employeeBean.getContact();
        String address = employeeBean.getAddress();
        String department = employeeBean.getDepartment();
        String emp_doj = employeeBean.getDoj();
        String salary = employeeBean.getSalary();
        
		String msg = null;
		try {
            //Validate First Name
            Pattern name_pattern = Pattern.compile("[a-zA-Z]{2,}");
            Matcher fname_matcher = name_pattern.matcher(emp_fname);
            boolean fname_b = fname_matcher.matches();
            
          //Validate Last Name
            Matcher lname_matcher = name_pattern.matcher(emp_lname);
            boolean lname_b = lname_matcher.matches();
            
          //Validate Email
            Pattern p_email = Pattern.compile("[a-zA-Z0-9\\.]{3,}@[a-z]{3,10}\\.[a-z]{2,}");
            Matcher m_email = p_email.matcher(emp_email);
            boolean b_email = m_email.matches();

          //Validate Contact Number
            Pattern p_contact = Pattern.compile("[1-9][0-9]{9}");
            Matcher m_contact = p_contact.matcher(emp_contact);
            boolean b_contact = m_contact.matches();
            
          //Validate Date Of Birth
            Pattern dob_pattern = Pattern.compile("[0-9]{1,2}/[0-9]{1,2}/[1-2][0-9]{3}");
            Matcher dob_matcher = dob_pattern.matcher(emp_dob);
            boolean dob_b = dob_matcher.matches();

          //Calculate Age From Date Of Birth and Validate Age
            int age = 0;
            LocalDate now = LocalDate.now(); //gets localDate
            if(!emp_dob.equals("")) {
	            String[] arr = emp_dob.split("/");
	            int day = Integer.parseInt(arr[0]);
	            int month = Integer.parseInt(arr[1]);
	            int year = Integer.parseInt(arr[2]);
	            LocalDate given_dob = LocalDate.of(year, month, day); 
	            Period diff = Period.between(given_dob, now); //difference between the dates is calculated
	            age = diff.getYears();
            }

            //Validate Date of Joining
            Period difference = null;
            if(!emp_doj.equals("")) {
	            String[] array = emp_doj.split("/");
	            int joined_day = Integer.parseInt(array[0]);
	            int joined_month = Integer.parseInt(array[1]);
	            int joined_year = Integer.parseInt(array[2]);
	            
	            LocalDate given_doj = LocalDate.of(joined_year, joined_month, joined_day); 
	            difference = Period.between(now, given_doj); //difference between the dates is calculated
            }
            
            Pattern sal_pattern = Pattern.compile("[0-9]{1,}");
            Matcher sal_matcher = sal_pattern.matcher(salary);
            boolean sal_b = sal_matcher.matches();
            //Validate Salary
            
            if(emp_fname.length()<2) {
                msg = "First Name Must Have Atleast 2 Characters";
            }
            
            else if(!fname_b) {
                msg = "First Name Can Have Only Characters";
            }
            
            else if(emp_lname.length()<2) {
                msg = "Last Name Must Have Atleast 2 Characters";
            }
            
            else if(!lname_b) {
                msg = "Last Name Can Have Only Characters";
            }
        
            else if(emp_email.length()==0) {
                msg = "Email Cannot Be Left Empty";
            }
            
            else if(!b_email) {
                msg = "Invalid Email Provided";
            }

            else if(!b_contact){
                msg = "Invalid Contact Number Provided";
            }
            
            else if(emp_dob.length()==0) {
                msg = "Date Of Birth Cannot Be Left Empty";
            }
            
            else if(age<18 || age>60) {
                msg = "Sorry, You Must Be Between 18 to 60 Years Old";
            }
            
            else if(!dob_b) {
                msg = "Invalid Date Of Birth Provided";
            }
            
            else if(emp_doj.length()==0) {
                msg = "Date Of Joining Cannot Be Left Empty";
            }

            else if(difference != null && (difference.getYears()>0 || difference.getDays()>0 || difference.getMonths()>0)) {
                msg = "Date Of Joining Not Applicable";
            }

            else if(address.length()==0){
                msg = "Address Field Cannot Be Empty";
            }           
            
            else if(department.length()==0){
                msg = "Department Field Cannot Be Left Empty";
            }
            
            else if(department.length()<2){
                msg = "Department Field Must Contain Atleast 2 Characters";
            }
            
            else if(!sal_b){
                msg = "Invalid Salary Entered";
            }
            
            else {
            	return "Success";
            }
			return msg;
		}catch(Exception e){
			return "Oops...Error In Adding Employee" + e;
		}
	}
	
	public String taskValidation(TaskBean taskBean) {
		
		String emp_id = taskBean.getEmp_id();
		String task_name = taskBean.getTask_name();
		String skills_req = taskBean.getSkills_required();
		String start_date = taskBean.getStart_date();
		String deadline = taskBean.getDeadline();
		
		String msg = null;
		
		try {
			
			Pattern p_id = Pattern.compile("[1-9][0-9]*");
	        Matcher m_id = p_id.matcher(emp_id);
	        boolean b_id = m_id.matches();
	        
	      //Validate Date Of Birth
            Pattern p_startdate = Pattern.compile("[0-9]{1,2}/[0-9]{1,2}/[1-2][0-9]{3}");
            Matcher m_startdate = p_startdate.matcher(start_date);
            boolean b_startdate = m_startdate.matches();
            Matcher m_deadline = p_startdate.matcher(deadline);
            boolean b_deadline = m_deadline.matches();
	        
	        if(emp_id.length() == 0) {
	        	msg = "Employee ID Cannot Be Empty";
	        }
	        
	        else if(!b_id) {
				msg = "Not A Valid Employee ID";
			}
				
	        else if(task_name.length() == 0) {
	        	msg = "Task Name Cannot Be Empty";
	        }
	        
	        else if(skills_req.length() == 0) {
	        	msg = "Skills Must Be Mentioned";
	        }
	        
	        else if(!b_startdate) {
	        	msg = "Invalid Start Date";
	        }
	        
	        else if(start_date.length() == 0) {
	        	msg = "Start Date Cannot Be Left Empty";
	        }
	        
	        else if(!b_deadline) {
	        	msg = "Invalid Deadline";
	        }
	        
	        else if(deadline.length() == 0) {
	        	msg = "Deadline Cannot Be Left Empty";
	        }
	        
	        else {
	        	msg = "Success";
	        }
			return msg;
		}catch(Exception e) {
			return "Oops...Error In Adding Task";
		}
	}
	
	public String leaveValidation(LeaveBean leaveBean) {
		
		String from_date = leaveBean.getFrom_date();
		String to_date = leaveBean.getTo_date();
		String reason = leaveBean.getReason();
		
		String msg = null;
		
		try {
			//Validate Date Of Birth
            Pattern p_fromdate = Pattern.compile("[0-9]{1,2}/[0-9]{1,2}/[1-2][0-9]{3}");
            Matcher m_fromdate = p_fromdate.matcher(from_date);
            boolean b_fromdate = m_fromdate.matches();
            Matcher m_todate = p_fromdate.matcher(to_date);
            boolean b_todate = m_todate.matches();
			
			if(from_date.length() == 0) {
				msg = "From Date Must Be Specified";
			}
			
			else if(!b_fromdate) {
				msg = "From Date Invalid";
			}
			
			else if(to_date.length() == 0) {
				msg = "To Date Must Be Specified";
			}
			
			else if(!b_todate) {
				msg = "To Date Invalid";
			}
			
			else if(reason.length() == 0) {
				msg = "Reason Must Be Specified";
			}
			
			else {
				msg = "Success";
			}
			
			return msg;
		}catch(Exception e) {
			return "Oops...Error In Applying Leave";
		}
	}
}
