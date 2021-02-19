package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class verifyOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session =req.getSession();
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String oldEmail=((String) session.getAttribute("email"));
		String oldOTP=((String) session.getAttribute("otp"));
		String email=req.getParameter("email").trim();
		String OTP=req.getParameter("otp").trim();
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		System.out.println(email+"--"+oldEmail+"--"+OTP+"--"+oldOTP);
		if(oldEmail==null||oldOTP==null)
		{
			out.println("SendOTPfirst");
		}
		else if(email==null||OTP==null||!email.matches("[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9a-z]+([.][A-Za-z0-9]+)+")||OTP.length()<=0||!oldEmail.equals(email)){
			System.out.println("here 1");
			out.println("500error");
		}
		else if(!oldOTP.equals(OTP))
		{
			out.println("otpNotMatched");
		}else if(oldOTP.equals(OTP)&&email.equals(oldEmail))
		{
			out.println("Success");
		}
		else
		{
			System.out.println("here 2");
			out.println("500error");
		}
	}

}
