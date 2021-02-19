package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.database.Database;
import com.database.UserBean;

@MultipartConfig
public class coverPhotoUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
   		String email=((UserBean)(req.getSession().getAttribute("userCurrent"))).getEmail().trim();
    	resp.setContentType("text/html");
    	
    	Part profilePicture=req.getPart("coverPic");
		System.out.println("pic");
		
    	if(Database.updateUserProfilePhoto("coverPicture",profilePicture,email,req, resp)==1){
    		try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				
				e.printStackTrace();
			}
			resp.sendRedirect("myProfile");
			
			
			
    	}
			
    	else {
    		resp.sendRedirect("500error");
    	}
	}

}
