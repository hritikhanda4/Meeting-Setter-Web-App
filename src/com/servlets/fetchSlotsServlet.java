package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;


@WebServlet("/fetchSlotsServlet")
public class fetchSlotsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String email=request.getParameter("email").trim();
			String date=request.getParameter("date").trim();
			PrintWriter out=response.getWriter();
			response.setContentType("text/html");
			int result=Database.fetchFreeSlots(email,date,request);
			if(result==1)
			{
				
				out.println("Success");
			}
			else
			{
				
				
				out.println("NotPresent");
			}
	}

}
