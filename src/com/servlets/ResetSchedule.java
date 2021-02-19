package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.ScheduleBean;

public class ResetSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ScheduleBean sb=(ScheduleBean)(request.getSession().getAttribute("userSchedule"));
		if(sb!=null){
    		System.out.println("Reset");
    	request.getSession().removeAttribute("userSchedule");
    	
    	}
		response.sendRedirect("mySchedule.jsp");
	}

}
