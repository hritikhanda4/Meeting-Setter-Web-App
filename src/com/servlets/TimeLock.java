package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.ScheduleBean;

public class TimeLock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Time Servlet");
		ScheduleBean sb=(ScheduleBean)request.getSession().getAttribute("userSchedule");
		sb.setAvailableHours(request.getParameter("startTime").trim()+"-"+request.getParameter("endTime").trim());
		request.getSession().setAttribute("userSchedule",sb);
		response.sendRedirect("mySchedule.jsp");
	}

}
