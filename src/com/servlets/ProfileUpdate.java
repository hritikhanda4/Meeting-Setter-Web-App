package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;


public class ProfileUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	
    	String email=req.getParameter("email").trim();
    	resp.setContentType("text/html");
    	PrintWriter out=resp.getWriter();
    	String col=req.getParameter("column").trim();
    	String val=req.getParameter("value").trim();
    	if(col.toLowerCase().equals("fname")||col.toLowerCase().equals("lname"))
    		val=val.substring(0,1).toUpperCase()+val.substring(1).toLowerCase();
    	else if(col.toLowerCase().equals("email"))
    	val=val.toLowerCase();
    	if(Database.updateUserProfile(col,val,email,req, resp)==1){
    		
			out.println("Success");
			
			
			
    	}
			
    	else {
			out.println("500error");}
	}

}
