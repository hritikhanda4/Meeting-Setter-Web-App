package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.database.Database;

public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		Thread.sleep(3000);
	} catch (InterruptedException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		HttpSession session =req.getSession();
		String oldEmail=((String) session.getAttribute("email")).trim();
		String email=req.getParameter("email").trim();
		String pass=req.getParameter("password").trim();
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		if(oldEmail==null||email==null||pass.length()<6||!email.matches("[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9a-z]+([.][A-Za-z0-9]+)+"))
		{
			out.println("500error");
		}
		else {
			System.out.println("******");
			if(Database.updateUserData(email,"PASSWORD",pass)==1)
			out.println("Success");
			else {
			out.println("500error");
			System.out.println("######");
			}
		}
	
	}

}
