package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;

public class SetupMeeting extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		PrintWriter out=resp.getWriter();
		resp.setContentType("text/html");
		String partnerEmail=req.getParameter("partnerEmail").trim();
		String userEmail=req.getParameter("email").trim();
		String date=req.getParameter("date").trim();
		String slot=req.getParameter("slot").trim();
		int result=Database.insertNotification(userEmail, partnerEmail, date, slot);
		if(result==1)
			out.println("Success");
		else if(result==-1) {
		System.out.println("I AM On");
			out.println("AlreadySent");
			
		}
		else
			out.println("500error");
		
		
		
	}

}
