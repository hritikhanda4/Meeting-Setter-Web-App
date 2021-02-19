package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.database.Database;
import com.database.UserBean;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	{

		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		
        String oldOtp=(String) req.getSession().getAttribute("otp");
        String otp= req.getParameter("otp").trim();
        if(oldOtp==null) {
        	
        	out.println("SendOtpFirst");
        	
        }
        else if(!oldOtp.equals(otp)) {
        	System.out.println(oldOtp+"--"+otp);
        	out.println("wrongOtp");
        }
        else {
		boolean flag=true;
		UserBean ub=new UserBean();
		String fname="",lname="";
		if(flag)
		if(req.getParameter("fname")!=null&&req.getParameter("fname").trim().length()>0)
		{
			fname=req.getParameter("fname").trim();
			fname=fname.substring(0,1).toUpperCase()+fname.substring(1,fname.length()).toLowerCase();
			ub.setFname(fname);
			
		}
		else {
			
			
			flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getParameter("lname")!=null&&req.getParameter("lname").trim().length()>0)
		{
			lname=req.getParameter("lname").trim();
			lname=lname.substring(0,1).toUpperCase()+lname.substring(1,lname.length()).toLowerCase();
			ub.setLname(lname);
		}
		else {
			
			flag=false;
			out.println("500error");
		}
		if(flag)	
		if(req.getParameter("email")!=null&&req.getParameter("email").trim().length()>0&&( req.getParameter("email").trim().matches("[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9a-z]+([.][A-Za-z0-9]+)+"))) {
			System.out.println("hello ");
			String email=req.getParameter("email").trim().toLowerCase();
			ub.setEmail(email);
		}
		else {
			flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getParameter("password")!=null&&req.getParameter("password").trim().length()>=6&&req.getParameter("confirmPassword")!=null&&req.getParameter("confirmPassword").trim().length()>=6&&req.getParameter("password").equals(req.getParameter("confirmPassword")))
		{
			String password=req.getParameter("password").trim();
			ub.setPassword(password);
		}
		else {
			
			flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getParameter("DOB")!=null&&req.getParameter("DOB").trim().length()==10)
		{
			String dob=req.getParameter("DOB").trim();
			ub.setDateOfBith(dob);
		}
		else {
						flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getParameter("genderRadio")!=null&&(req.getParameter("genderRadio").trim().equals("Male")||req.getParameter("genderRadio").trim().equals("Female")))
		{
			String gender=req.getParameter("genderRadio").trim();
			ub.setGender(gender);
		}
		else {
			
			flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getParameter("company")!=null&&req.getParameter("company").trim().length()>0) {
			String company=req.getParameter("company").trim();
			ub.setCompany(company);
		}
		else {
			
			flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getParameter("contact")!=null||req.getParameter("contact").trim().length()==10) {
			String contact=req.getParameter("contact").trim();
			ub.setContact(contact);
		}
		else {
						flag=false;
			out.println("500error");
		}
		if(flag)
		if(req.getPart("profilePicture")!=null)
		{
			
			Part profilePicture=req.getPart("profilePicture");
			ub.setProfilePicture(profilePicture.getInputStream());
		}
		else {
						flag=false;
			
			out.println("500error");
		}
		
		if(req.getPart("coverPicture")!=null)
		{
			
			Part coverPicture=req.getPart("coverPicture");
			ub.setCoverPicture(coverPicture.getInputStream());
		}	
			
//		 Validations ends here	
		
		// At this point if flag is true it means data is correct
		
		if(flag) {
			ub.setUsername(fname+" "+lname);
			
			int result=Database.registerData(ub);
			System.out.println(result);
			if(result==1)
				out.println("RegisteredSuccess");
			else if(result==0)
				out.println("AlreadyRegistered");
			else
				out.println("500error");
			
		}
		else
		{
			System.out.println("Error");
			out.println("500error");
		}
		
		
			
	}
	}
}
	
}
