package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;

public class AcceptRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String myEmail=req.getParameter("myEmail").trim();
		String requestEmail=req.getParameter("requestEmail").trim();
		PrintWriter out=resp.getWriter();
		int result=Database.acceptFriendRequest(myEmail,requestEmail);
		if(result==1)
		{
			out.println("Success");
			
		}
		else {
			out.println("500error");
		}
	}
		
		
}


