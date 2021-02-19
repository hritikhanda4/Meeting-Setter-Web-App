package com.servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.database.UserBean;


public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static boolean logout=false;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		UserBean ub=(UserBean) session.getAttribute("userCurrent");
		
		
		File fp=new File(req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg"));
		if(fp.exists())
			fp.delete();
		File fc=new File(req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg"));
		if(fc.exists())
			fc.delete();
		
		session.invalidate();
		logout=true;
		resp.sendRedirect("about.jsp");
		
	}


}
