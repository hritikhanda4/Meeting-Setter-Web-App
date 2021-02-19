package com.servlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.Database;


public class MailServlet extends HttpServlet {
	

	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int result= Database.authenticateUserForReset(req,resp);
		if(result==1)
		{
		// generating 6 digit random number otp
		int min=100000;
		int max=999999;
		String otp = (int)(Math.random()*(max-min+1)+min)+""; 
		String from="info.meetingsetter@gmail.com";
		String password="DivDivDiv";
		String to=req.getParameter("email").trim().toLowerCase();
		
		String sub="Meeting Setter Web App OTP";
		String msg="Hlo User\nYour OTP is: "+otp+"\nThanks For Using Meeting Setter Web App";
		
		 Properties props = new Properties();    
         props.put("mail.smtp.host", "smtp.gmail.com");    
         props.put("mail.smtp.socketFactory.port", "465");    
         props.put("mail.smtp.socketFactory.class",    
                   "javax.net.ssl.SSLSocketFactory");    
         props.put("mail.smtp.auth", "true");    
         props.put("mail.smtp.port", "465");    
         //get Session   
         Session session = Session.getDefaultInstance(props,    
          new javax.mail.Authenticator() {    
          protected PasswordAuthentication getPasswordAuthentication() {    
          return new PasswordAuthentication(from,password);  
          }    
         });    
         //compose message    
         try {    
          MimeMessage message = new MimeMessage(session);    
          message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));    
          message.setSubject(sub);    
          message.setText(msg);    
          //send message  
          Transport.send(message);  
          System.out.println("Message send");
          req.getSession().setAttribute("email", to);
          req.getSession().setAttribute("otp",otp);
          
         } catch (MessagingException e) {
        	 throw new RuntimeException(e);
         }   
            
		
	}
		else
		{
			PrintWriter out=resp.getWriter();
			System.out.println("not registered");
			out.println("NotRegistered");
		}

}
}
