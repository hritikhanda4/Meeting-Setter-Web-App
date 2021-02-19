package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.database.Database;
import com.database.MeetingBean;
import com.database.Prop;
import com.database.UserBean;
import com.token.*;
public class JoinMeetingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
	
		resp.setContentType("text/html");
		PrintWriter out = null;
		try {
			out = resp.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		HttpSession session=req.getSession();
		String roomId=req.getParameter("roomId").trim();
		String password=req.getParameter("password").trim();
		String username=((UserBean)(session.getAttribute("userCurrent"))).getFname()+" "+((UserBean)(session.getAttribute("userCurrent"))).getLname().trim();
		StringBuffer devKey=new StringBuffer("");
		boolean result=Database.verifyMeetingPassword(roomId,password,devKey);

		String token=GenerateToken.getToken((new String(devKey)).trim(),com.database.Prop.vidyoAppID,((UserBean)(session.getAttribute("userCurrent"))).getFname().trim()+((UserBean)(session.getAttribute("userCurrent"))).getLname().trim(), null, "9999");
	
		if(result)
		{
			MeetingBean mb=new MeetingBean(roomId,password,token,username);
			session.setAttribute("userMeeting",mb);
			out.println("Success");
			
		}
		else
		{
			
			out.println("RoomNotExistOrPasswordNotMatched");
			
		}
		
		
	}

}
