package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;
import com.database.UserBean;

public class RejectMeetingRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out=resp.getWriter();
		resp.setContentType("text/html");
		
		String email=((UserBean)(req.getSession().getAttribute("userCurrent"))).getEmail().trim();
		String requestEmail=req.getParameter("partnerEmail").trim();
		String slot=req.getParameter("slot").trim();
		String date=req.getParameter("date").trim();
		int result=Database.rejectMeetingFriendRequest(email,requestEmail,date,slot);
		if(result==1)
		{
			out.println("Success");
			
		}
		else {
			out.println("500error");
		}

		
		
	}

}
