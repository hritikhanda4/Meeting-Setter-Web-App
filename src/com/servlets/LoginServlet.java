package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		if(req.getParameter("email")==null||req.getParameter("password")==null||!( req.getParameter("email").trim().matches("[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9a-z]+([.][A-Za-z0-9]+)+"))||req.getParameter("password").trim().length()<6)
		{
			
			resp.sendRedirect("Error");
		}	
		int result= Database.authenticateUser(req,resp);
		
		
		if(result==0)
		{
			//Unauthorised access
			out.println("NotMatched");
		}
		else if(result==1)
		{ 
			out.println("Matched");
		}
		else if(result==-1) {
			//User not registered
			
			
			out.println("NotRegistered");
		}
		else if(result==-2)
		{
			
			out.println("500Error");
		}
		else
		{
			
			out.println("Error");			
		}
		
		System.out.println(result);
			
		}
	}
