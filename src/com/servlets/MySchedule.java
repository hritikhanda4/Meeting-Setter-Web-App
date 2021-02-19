package com.servlets;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.database.Database;
import com.database.ScheduleBean;
import com.database.UserBean;

public class MySchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=((UserBean)(request.getSession().getAttribute("userCurrent"))).getEmail().trim();
		String date=request.getParameter("date").trim();
		int result=Database.SchedulePresent(email,date,request);
		if(result==1)
		{
			response.sendRedirect("mySchedule.jsp");
		}
		else
		{
			ScheduleBean sc=new ScheduleBean();
			sc.setEmail(email);
			sc.setDate(date);
			request.getSession().setAttribute("userSchedule", sc);
			response.sendRedirect("mySchedule.jsp");
			
		}
	}

}
