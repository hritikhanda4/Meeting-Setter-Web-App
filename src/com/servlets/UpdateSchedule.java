package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;
import com.database.ScheduleBean;

public class UpdateSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		
		String email=req.getParameter("email").trim();
		 String freeSlots=req.getParameter("freeSlotsArr").trim();
		 String occupiedSlots=req.getParameter("occupiedSlotsArr").trim();
		 String date=req.getParameter("date").trim();
		 String startTime=req.getParameter("startTime").trim();
		 String endTime=req.getParameter("endTime").trim();
		String availableHours=startTime+"-"+endTime;
		
		ScheduleBean sb=new ScheduleBean();
		sb.setEmail(email);
		sb.setAvailableHours(availableHours);
		sb.setDate(date);
		sb.setFreeSlots(freeSlots);
		sb.setOccupiedSlots(occupiedSlots);
		
		PrintWriter out= resp.getWriter();
		resp.setContentType("text/html");
		if(Database.updateSchedule(sb)==1) {
			out.println("Success");
		}
		else
			out.println("500error");
		}
		 
	}
