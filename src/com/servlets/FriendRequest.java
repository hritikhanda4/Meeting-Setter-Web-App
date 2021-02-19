package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;

public class FriendRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String senderEmail=req.getParameter("senderEmail").trim();
		String recieverEmail=req.getParameter("recieverEmail").trim();
		PrintWriter out=resp.getWriter();
		int result=Database.insertRequest(senderEmail,recieverEmail);
		
		if(result==1)
		{
			out.println("Success");
			
		}
		else {
			out.println("500error");
		}
		
	}

}
