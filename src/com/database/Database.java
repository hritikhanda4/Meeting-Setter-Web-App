package com.database;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Random;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


//    CALL SYSPROC.ADMIN_CMD('REORG TABLE USERDATA') ---668
@MultipartConfig(maxFileSize = 506177215)
public class Database {
	static public Connection con;
	public static HashSet<String> friends=new HashSet<String>();
	public static HashSet<String> requests=new HashSet<String>();
	
	public static void createCon() throws SQLException, ClassNotFoundException {
		String Driver=null;
		String url = null;
		String user=null;
		String password=null;
		String DATABASE="IBM";
		if(DATABASE.equals("IBM")) {
			Driver=Prop.dbDriver;
			url=Prop.dbUrl;
			user=Prop.dbUsername;
			password=Prop.dbPassword;
		}
		else if(DATABASE.equals("MySQL")) {
			Driver="com.mysql.cj.jdbc.Driver";
			url="jdbc:mysql://localhost:3306/MeetingSetterWebApp";
			user="root";
			password="root";
		}	
		Class.forName(Driver);
		con=DriverManager.getConnection(url, user, password);
		System.out.println("Connected Successfully");	
	
	}
	public static int authenticateUser(HttpServletRequest req, HttpServletResponse resp)  {
		System.out.println("Authenticating user!");
		try {
		createCon();
		String userEmail=req.getParameter("email").trim();
		String userPassword=req.getParameter("password").trim();
		String dbPassword=null;
		Statement st=con.createStatement();
		ResultSet set=st.executeQuery("SELECT * from  \"USERDATA\" where \"EMAIL\"='"+userEmail+"'");
		if(set.next())
		if(set.getString("PASSWORD")!=null)
		dbPassword=(String) set.getString("PASSWORD");
		
		if(dbPassword==null)
			return -1;    // User not registered
		else {
			
			if(!userPassword.equals(dbPassword.trim()))       // as in database password is of 30 char so password will be Qwerty_____________ spaces upto 30 chars so we trim it first then process it
			{

				return 0;   // Password does not match
			}
			else {
				UserBean ub=new UserBean();
				ub.setFname(set.getString(1).trim());
				ub.setLname(set.getString(2).trim());
				ub.setEmail(set.getString(3).trim());
				ub.setUsername(set.getString(4).trim());
				ub.setPassword(set.getString(5).trim());
				ub.setDateOfBith(set.getString(6).trim());
				ub.setGender(set.getString(7).trim());
				ub.setCompany(set.getString(8).trim());
				ub.setContact(set.getString(9).trim());
				ub.setProfilePicture(set.getBinaryStream(10));
				ub.setCoverPicture(set.getBinaryStream(11));
				
				insertProfileImage(ub,req,resp);
				insertCoverImage(ub,req,resp);
				Thread.sleep(5000);
				HttpSession session=req.getSession();
				session.setAttribute("userCurrent", ub);
				return 1;   //Password matches
			}		
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return -2;     // Any 500 error occurred
			
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				return -2;   
			}
		}
		
		
		
	}
	//authenticating for reset password
		public static int authenticateUserForReset(HttpServletRequest req, HttpServletResponse resp)  {
			System.out.println("Authenticating user!");
			try {
			createCon();
			String userEmail=req.getParameter("email");
			String newAccount=req.getParameter("newAccount");
			if(newAccount!=null&&newAccount.equals("True"))
				return 1;
			Statement st=con.createStatement();
			ResultSet set=st.executeQuery("SELECT * from  \"USERDATA\" where \"EMAIL\"='"+userEmail+"'");
			if(set.next())
			{
				return 1;
			}
			else
			{
				return -2;
			}
			
			}
			catch(Exception e) {
				e.printStackTrace();
				return -2;     // Any 500 error occurred
				
			}
			finally {
				try {
					close();
				} catch (SQLException e) {
					return -2;   
				}
			}
			
			
			
		}

		
		
		


		
	
	private static void insertCoverImage(UserBean ub,HttpServletRequest req,HttpServletResponse resp) throws IOException {
		if(ub.getCoverPicture()!=null) {
			try {
			      InputStream is=ub.getCoverPicture();
	              byte buffer[]=new byte[is.available()];
	              is.read(buffer);
	              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg");
	              File f=new File(path);
	              if(!f.exists())
	            	  f.createNewFile();
	              OutputStream os=new FileOutputStream(path);
	              os.write(buffer);
	              is.close();
	              os.close();

	              if(f.length()==0)
	            	  throw new Exception();
			}
			catch(Exception e) {
				 InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/bg4.png"));
	              byte buffer[]=new byte[is.available()];
	              is.read(buffer);
	              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg");
	              File f=new File(path);
	              if(!f.exists())
	            	  f.createNewFile();
	              OutputStream os=new FileOutputStream(path);
	              os.write(buffer);
	              is.close();
	              os.close();
			}
		}
		else
		{
			 InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/bg4.png"));
              byte buffer[]=new byte[is.available()];
              is.read(buffer);
              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg");
              File f=new File(path);
              if(!f.exists())
            	  f.createNewFile();
              OutputStream os=new FileOutputStream(path);
              os.write(buffer);
              is.close();
              os.close();
		}
		
	}

	private static void insertProfileImage(UserBean ub,HttpServletRequest req,HttpServletResponse resp) throws IOException {
		if(ub.getProfilePicture()!=null)
		{
			try {
              InputStream is=ub.getProfilePicture();
              byte buffer[]=new byte[is.available()];
              is.read(buffer);
              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg");
              File f=new File(path);
              if(f.exists())
            	  f.delete();
              
              if(!f.exists())
            	  f.createNewFile();
              
              OutputStream os=new FileOutputStream(path);
              os.write(buffer);
              is.close();
              os.close();
              
              if(f.length()==0)
            	  throw new Exception();
			}
			catch(Exception e) {

				 InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/dp1.jpg"));
	              byte buffer[]=new byte[is.available()];
	              is.read(buffer);
	              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg");
	              File f=new File(path);
	              if(!f.exists())
	            	  f.createNewFile();
	              OutputStream os=new FileOutputStream(path);
	              os.write(buffer);
	              is.close();
	              os.close();
			}
              
		}
		else {
			  InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/dp1.jpg"));
              byte buffer[]=new byte[is.available()];
              is.read(buffer);
              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg");
              File f=new File(path);
              if(!f.exists())
            	  f.createNewFile();
              OutputStream os=new FileOutputStream(path);
              os.write(buffer);
              is.close();
              os.close();
		}
		
		
	}


	public static int registerData(UserBean ub)   {
		// -668 error --  CALL SYSPROC.ADMIN_CMD('REORG TABLE USERDATA');	
		
		
		try {
		Database.createCon();
		String query="INSERT  INTO   \""+"USERDATA"+"\" (\"FNAME\",\"LNAME\",\"EMAIL\",\"USERNAME\",\"PASSWORD\",\"DATEOFBIRTH\",\"GENDER\",\"COMPANY\",\"CONTACT\",\"PROFILEPICTURE\",\"COVERPICTURE\") values(?,?,?,?,?,?,?,?,?,?,?)";
		//For mysql---String query="INSERT  INTO "+tableName+" (fname,lname,email,username,password,dateOfBith,gender,company,contact,profilePicture,coverPicture) values(?,?,?,?,?,?,?,?,?,?,?)";
			
		PreparedStatement psmt=con.prepareStatement(query);
		
		psmt.setString(1,ub.getFname());
		psmt.setString(2,ub.getLname());
		psmt.setString(3,ub.getEmail());
		psmt.setString(4,ub.getUsername());
		psmt.setString(5,ub.getPassword());
		psmt.setString(6,ub.getDateOfBith());
		psmt.setString(7,ub.getGender());
		psmt.setString(8,ub.getCompany());
		psmt.setString(9,ub.getContact());
		psmt.setBinaryStream(10, ub.getProfilePicture());
		psmt.setBinaryStream(11, ub.getCoverPicture());
		psmt.executeUpdate();
		System.out.println("Insert Success");
		return 1;
		}
		catch(Exception e) {
			String db=null;
			try {
			Statement st=con.createStatement();
			ResultSet set=st.executeQuery("SELECT \"EMAIL\" from  \"USERDATA\" where \"EMAIL\"='"+ub.getEmail()+"'");
			if(set.next())
			if(set.getString("EMAIL")!=null)
			db=(String) set.getString("EMAIL");
			if(db!=null)
				{
					return 0;
				}
			else
			{
				return -1;
			}
			}
			catch(Exception ev) {
				return -2;
			}
		}
		finally {	
		try {
			Database.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		}
	}
	
	
	public static ResultSet ProfilePhoto(String email) throws SQLException, IOException, ClassNotFoundException{
		ResultSet rs=null;
		try {
		createCon();
	Statement st=con.createStatement();
	rs=st.executeQuery("SELECT \"PROFILEPICTURE\" from USERDATA where email='"+email+"'");
	rs.next();
		}
		catch(Exception e) {
			e.printStackTrace();
			
		}
		finally {
			close();
		}
	return rs;

	}
	public static int updateUserData(String email,String columnName,Object value){
		try {
		createCon();
		String query = null;
		
			String stringValue;
			stringValue=(String) value;
			query="UPDATE \"USERDATA\" set \""+columnName+"\"='"+stringValue+"' where \"EMAIL\"='"+email+"'";
			System.out.println(query);
		
		
		Statement st=con.createStatement();
		st.executeUpdate(query);
		return 1;
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		
	}
public static ResultSet getNotifications(String email){
		
		try {
		createCon();
		String q="SELECT * FROM \"NOTIFICATIONS\" where \"EMAIL\"='"+email+"'";
		ResultSet rs=con.createStatement().executeQuery(q);
		System.out.println("Meeings fetched");
		return rs;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	public static ResultSet getMeetings(String email){
		
		try {
		createCon();
		String q="SELECT  \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"MEETINGDATA\".\"DATE\", \"MEETINGDATA\".\"STARTINGTIME\",\"MEETINGDATA\".\"ENDINGTIME\",\"MEETINGDATA\".\"ROOMID\",\"MEETINGDATA\".\"PASSWORD\" FROM \"USERDATA\" INNER JOIN \"MEETINGDATA\" ON \"USERDATA\".\"EMAIL\" = \"MEETINGDATA\".\"PARTNEREMAIL\" and \"MEETINGDATA\".\"EMAIL\"='"+email+"' ORDER BY DATE";
		ResultSet rs=con.createStatement().executeQuery(q);
		System.out.println("Meetings fetched");
		
		return rs;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	public static ResultSet getSearch(String content,String myEmail) {
		
		String q=null;
		if(content.matches("[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9a-z]+([.][A-Za-z0-9]+)+"))
		{
			q="SELECT \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"USERDATA\".\"DATEOFBIRTH\",\"USERDATA\".\"GENDER\",\"USERDATA\".\"COMPANY\",\"USERDATA\".\"CONTACT\" FROM \"USERDATA\" where (\"USERDATA\".\"EMAIL\"='"+content+"') and (\"USERDATA\".\"EMAIL\"!='"+myEmail+"')"; 
			
		}
		else {
			String content1=new String(content);
			    String words[]=content.split("\\s");  
			    String capitalizeWord="";  
			    for(String w:words){  
			        String first=w.substring(0,1);  
			        String afterfirst=w.substring(1);  
			        capitalizeWord+=first.toUpperCase()+afterfirst+" ";  
			    }  
			    content=capitalizeWord.trim();  
			  
			q="SELECT  \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"USERDATA\".\"DATEOFBIRTH\",\"USERDATA\".\"GENDER\",\"USERDATA\".\"COMPANY\",\"USERDATA\".\"CONTACT\" FROM \"USERDATA\" where (\"USERDATA\".\"EMAIL\" LIKE '%"+content1+"%' or \"USERDATA\".\"FNAME\" LIKE '%"+content+"%' or \"USERDATA\".\"LNAME\" LIKE '%"+content+"%' or \"USERDATA\".\"USERNAME\" LIKE '%"+content+"%' or \"USERDATA\".\"CONTACT\" LIKE '%"+content+"%') and (\"USERDATA\".\"EMAIL\"!='"+myEmail+"')"; 
			
		}
		
		try {
			createCon();
			String q1="SELECT  \"FRIENDLIST\".\"FRIENDEMAIL\" FROM \"FRIENDLIST\" where \"EMAIL\" = '"+myEmail+"'";
			ResultSet friendsSet=con.createStatement().executeQuery(q1);
			friends.clear();
			requests.clear();
			while(friendsSet.next()) {
				friends.add(friendsSet.getString(1));
			}
			friendsSet.close();
			
			String q2="SELECT  \"FRIENDREQUESTS\".\"EMAIL\" FROM \"FRIENDREQUESTS\" where \"REQUESTEMAIL\" = '"+myEmail+"'";
			ResultSet requestsSet=con.createStatement().executeQuery(q2);
			while(requestsSet.next()) {
				requests.add(requestsSet.getString(1));
			}
			requestsSet.close();
			
			
			System.out.println(q);
			ResultSet rs=con.createStatement().executeQuery(q);
			
			System.out.println("Search Result fetched");
			
			return rs;
			}
			catch(Exception e) {
				System.out.println("hello-3");
				e.printStackTrace();
			}
			
			return null;
		
	}

public static ResultSet getFriendRequests(String email){
	
	try {
	createCon();
	String q="SELECT  \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"USERDATA\".\"DATEOFBIRTH\",\"USERDATA\".\"GENDER\",\"USERDATA\".\"COMPANY\",\"USERDATA\".\"CONTACT\" FROM \"USERDATA\" INNER JOIN \"FRIENDREQUESTS\" ON \"USERDATA\".\"EMAIL\" = \"FRIENDREQUESTS\".\"REQUESTEMAIL\" and \"FRIENDREQUESTS\".\"EMAIL\"='"+email+"'"; 
	ResultSet rs=con.createStatement().executeQuery(q);
	System.out.println("Requests fetched");
	return rs;
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	
	return null;
}

public static ResultSet getFriendList(String email){
	
	try {
	createCon();
	String q="SELECT  \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"USERDATA\".\"DATEOFBIRTH\",\"USERDATA\".\"GENDER\",\"USERDATA\".\"COMPANY\",\"USERDATA\".\"CONTACT\" FROM \"USERDATA\" INNER JOIN \"FRIENDLIST\" ON \"USERDATA\".\"EMAIL\" = \"FRIENDLIST\".\"FRIENDEMAIL\" and \"FRIENDLIST\".\"EMAIL\"='"+email+"'"; 
	ResultSet rs=con.createStatement().executeQuery(q);
	System.out.println("List fetched");
	return rs;
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	
	return null;
}

public static int deleteFriendRequest(String myEmail,String requestEmail){
	
	try {
	createCon();
	String q1="DELETE FROM  \"FRIENDREQUESTS\" where \"EMAIL\" = '"+myEmail+"' and \"REQUESTEMAIL\" = '"+requestEmail+"'";
//	String q="SELECT  \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"USERDATA\".\"DATEOFBIRTH\",\"USERDATA\".\"GENDER\",\"USERDATA\".\"COMPANY\",\"USERDATA\".\"CONTACT\" FROM \"USERDATA\" INNER JOIN \"FRIENDREQUESTS\" ON \"USERDATA\".\"EMAIL\" = \"FRIENDREQUESTS\".\"REQUESTEMAIL\" and \"FRIENDREQUESTS\".\"EMAIL\"='"+email+"'"; 
	System.out.println(q1);
	con.createStatement().executeUpdate(q1);
	String q2="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\") VALUES('"+requestEmail+"','"+myEmail+" has rejected your friend Request')";
	System.out.println(q2);
	con.createStatement().executeUpdate(q2);
	
	
	System.out.println("Rejected Success");
	return 1;
	
	}
	catch(Exception e) {
		e.printStackTrace();
		return 0;
	}
	finally {
		try {
			close();
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
		
	}
	
}
		
	
	
	
	
	public static void close() throws SQLException{
		con.close();
		System.out.println("Connection closed");
	}
	public static boolean verifyMeetingPassword(String roomId,String password,StringBuffer key) {
		try{
			
			createCon();
		key.append(Prop.vidyoDevKey);
		String query="SELECT \"PASSWORD\" FROM \"MEETINGDATA\" where \"ROOMID\"='"+roomId+"'";
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery(query);
		if(rs.next())
		{
			System.out.println("here");
			
		if(rs.getString(1)!=null&&rs.getString(1).trim().equals(password))
			return true;      ///success
		else 
			return false;     // password wrong
		
		}
		
		else {
			System.out.println("Here 2");
			return false;    // room id wrong
		}
		}
		catch(Exception e) {
			e.printStackTrace();    
		return false;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		}
	}

	public static int getProfile(HttpServletRequest req, HttpServletResponse resp)  {
		System.out.println("Fetching Profile");
		try {
		createCon();
		String userEmail=req.getParameter("email");
		Statement st=con.createStatement();
		ResultSet set=st.executeQuery("SELECT * from  \"USERDATA\" where \"EMAIL\"='"+userEmail+"'");
		if(set.next()) {
				UserBean ub=new UserBean();
				ub.setFname(set.getString(1).trim());
				ub.setLname(set.getString(2).trim());
				ub.setEmail(set.getString(3).trim());
				ub.setUsername(set.getString(4).trim());
				ub.setPassword(set.getString(5).trim());
				ub.setDateOfBith(set.getString(6).trim());
				ub.setGender(set.getString(7).trim());
				ub.setCompany(set.getString(8).trim());
				ub.setContact(set.getString(9).trim());
				ub.setProfilePicture(set.getBinaryStream(10));
				ub.setCoverPicture(set.getBinaryStream(11));
				
				
				if(ub.getProfilePicture()!=null)
				{
					try {
		              InputStream is=ub.getProfilePicture();
		              byte buffer[]=new byte[is.available()];
		              is.read(buffer);
		              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg");
		              File f=new File(path);
		              if(f.exists())
		            	  f.delete();
		              
		              if(!f.exists())
		            	  f.createNewFile();
		              
		              OutputStream os=new FileOutputStream(path);
		              os.write(buffer);
		              is.close();
		              os.close();
		              
		              if(f.length()==0)
		            	  throw new Exception();
					}
					catch(Exception e) {

						 InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/dp1.jpg"));
			              byte buffer[]=new byte[is.available()];
			              is.read(buffer);
			              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg");
			              File f=new File(path);
			              if(!f.exists())
			            	  f.createNewFile();
			              OutputStream os=new FileOutputStream(path);
			              os.write(buffer);
			              is.close();
			              os.close();
					}
		              
				}
				else {
					  InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/dp1.jpg"));
		              byte buffer[]=new byte[is.available()];
		              is.read(buffer);
		              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Profile.jpg");
		              File f=new File(path);
		              if(!f.exists())
		            	  f.createNewFile();
		              OutputStream os=new FileOutputStream(path);
		              os.write(buffer);
		              is.close();
		              os.close();
				}
				if(ub.getCoverPicture()!=null) {
					try {
					      InputStream is=ub.getCoverPicture();
			              byte buffer[]=new byte[is.available()];
			              is.read(buffer);
			              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg");
			              File f=new File(path);
			              if(!f.exists())
			            	  f.createNewFile();
			              OutputStream os=new FileOutputStream(path);
			              os.write(buffer);
			              is.close();
			              os.close();

			              if(f.length()==0)
			            	  throw new Exception();
					}
					catch(Exception e) {
						 InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/bg4.png"));
			              byte buffer[]=new byte[is.available()];
			              is.read(buffer);
			              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg");
			              File f=new File(path);
			              if(!f.exists())
			            	  f.createNewFile();
			              OutputStream os=new FileOutputStream(path);
			              os.write(buffer);
			              is.close();
			              os.close();
					}
				}
				else
				{
					 InputStream is=new FileInputStream(req.getServletContext().getRealPath("/img/bg4.png"));
		              byte buffer[]=new byte[is.available()];
		              is.read(buffer);
		              String path=req.getServletContext().getRealPath("/resources/"+ub.getEmail().trim()+"Cover.jpg");
		              File f=new File(path);
		              if(!f.exists())
		            	  f.createNewFile();
		              OutputStream os=new FileOutputStream(path);
		              os.write(buffer);
		              is.close();
		              os.close();
				}
				Thread.sleep(4000);
				HttpSession session=req.getSession();
				session.setAttribute("userProfile", ub);
				return 1;   // Operation Success
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			return -2;     // Any 500 error occurred
			
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				return -2;   
			}
		}
		return -2;
		
		
		
	}
	public static int insertRequest(String senderEmail, String recieverEmail) {
		String q="INSERT  INTO   \""+"FRIENDREQUESTS"+"\" (\"EMAIL\",\"REQUESTEMAIL\") values('"+recieverEmail+"','"+senderEmail+"')";
		
		try {
			
			createCon();
			Statement st=con.createStatement();
			st.executeUpdate(q);
			System.out.println("Insert Success");
			return 1;
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
			
				e.printStackTrace();
			}
		}

		
	}
	public static int acceptFriendRequest(String myEmail, String requestEmail) {

		try {
		createCon();
		String q1="DELETE FROM  \"FRIENDREQUESTS\" where \"EMAIL\" = '"+myEmail+"' and \"REQUESTEMAIL\" = '"+requestEmail+"'";
//		String q="SELECT  \"USERDATA\".\"EMAIL\",\"USERDATA\".\"USERNAME\",\"USERDATA\".\"DATEOFBIRTH\",\"USERDATA\".\"GENDER\",\"USERDATA\".\"COMPANY\",\"USERDATA\".\"CONTACT\" FROM \"USERDATA\" INNER JOIN \"FRIENDREQUESTS\" ON \"USERDATA\".\"EMAIL\" = \"FRIENDREQUESTS\".\"REQUESTEMAIL\" and \"FRIENDREQUESTS\".\"EMAIL\"='"+email+"'"; 
		System.out.println(q1);
		con.createStatement().executeUpdate(q1);
		String q2="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\") VALUES('"+requestEmail+"','"+myEmail+" has Accepted your friend Request, Now you can set meetings easily')";
		System.out.println(q2);
		con.createStatement().executeUpdate(q2);
		
		String q3="INSERT INTO   \"FRIENDLIST\" (\"EMAIL\",\"FRIENDEMAIL\") VALUES('"+myEmail+"','"+requestEmail+"')";
		System.out.println(q3);
		con.createStatement().executeUpdate(q3);
		
		String q4="INSERT INTO   \"FRIENDLIST\" (\"EMAIL\",\"FRIENDEMAIL\") VALUES('"+requestEmail+"','"+myEmail+"')";
		System.out.println(q4);
		con.createStatement().executeUpdate(q4);
		
		
		System.out.println("Rejected Success");
		return 1;
		
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
			
				e.printStackTrace();
			}
			
		}
		
	}
	//update profile
	public static int updateUserProfile(String columnName,String newname,String email,HttpServletRequest req, HttpServletResponse resp){
		HttpSession session =req.getSession();
		UserBean ub=(UserBean) session.getAttribute("userCurrent");
		try {
		createCon();
		
		String query="UPDATE \"USERDATA\" set \""+columnName.toUpperCase()+"\"='"+newname+"' where \"EMAIL\"='"+email+"'";
		System.out.println(query);		
		Statement st=con.createStatement();
		st.executeUpdate(query);
		
		
		String userEmail=ub.getEmail();
		String userPassword=ub.getPassword();
		String dbPassword=null;
		
		ResultSet set=st.executeQuery("SELECT * from  \"USERDATA\" where \"EMAIL\"='"+userEmail+"'");
		if(set.next())
		if(set.getString("PASSWORD")!=null)
		dbPassword=(String) set.getString("PASSWORD");
		
		if(dbPassword==null)
			 return 0;   // User not registered
		else {
			
			if(!userPassword.equals(dbPassword.trim()))       // as in database password is of 30 char so password will be Qwerty_____________ spaces upto 30 chars so we trim it first then process it
			{
return 0;
				  // Password does not match
			}
			else {
				UserBean ubNew=new UserBean();
				ubNew.setFname(set.getString(1).trim());
				ubNew.setLname(set.getString(2).trim());
				ubNew.setEmail(set.getString(3).trim());
				ubNew.setUsername(set.getString(4).trim());
				ubNew.setPassword(set.getString(5).trim());
				ubNew.setDateOfBith(set.getString(6).trim());
				ubNew.setGender(set.getString(7).trim());
				ubNew.setCompany(set.getString(8).trim());
				ubNew.setContact(set.getString(9).trim());
				ubNew.setProfilePicture(ub.getProfilePicture());
				ubNew.setCoverPicture(ub.getCoverPicture());
				
			//	ub.setProfilePicture(set.getBinaryStream(10));
			//	ub.setCoverPicture(set.getBinaryStream(11));
				
				session.removeAttribute("userCurrent");
				session.setAttribute("userCurrent", ubNew);
				String query2="UPDATE \"USERDATA\" set \"USERNAME\"='"+ubNew.getFname()+" "+ubNew.getLname()+"' where \"EMAIL\"='"+email+"'";
				System.out.println(query2);		
				Statement st2=con.createStatement();
				st2.executeUpdate(query2);
				
			}
		return 1;
		}
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			
			try {
				close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	//profilePhotoUpdate
	
	public static int updateUserProfilePhoto(String columnName,Part newname,String email,HttpServletRequest req, HttpServletResponse resp){
		HttpSession session =req.getSession();
		UserBean ub=(UserBean) session.getAttribute("userCurrent");
		try {
		createCon();
		
			System.out.println("run");
			
			
			
			System.out.println("I am here");
			String query="UPDATE USERDATA set \""+columnName.toUpperCase()+"\"= ?  where \"EMAIL\"='"+email+"'";
			PreparedStatement stmt=con.prepareStatement(query);  
			stmt.setBinaryStream(1,newname.getInputStream());
			stmt.executeUpdate();
			System.out.println("qiry");
		
		
		if(columnName.equals("profilePicture"))
		{
			ub.setProfilePicture(newname.getInputStream());
			insertProfileImage(ub,req,resp);
		}
		else
		{
			
			ub.setCoverPicture(newname.getInputStream());
			insertCoverImage(ub,req,resp);
		}
		
		return 1;		
			}
		
		
		
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
			
				e.printStackTrace();
			}
		}
		
		
		}
	

	public static int insertNotification(String myEmail, String partnerEmail,String date,String slot) {
		
		try {
		createCon();
		String already="SELECT * FROM \"NOTIFICATIONS\" where \"EMAIL\"='"+partnerEmail.trim()+"' and \"PARTNEREMAIL\"='"+myEmail.trim()+"' and \"DATE\"='"+date.trim()+"' and \"SLOT\"='"+slot.trim().replace('-',',')+"'";
		ResultSet set=con.createStatement().executeQuery(already);
		if(set.next()) {
			
			return -1;
			
		}
		set.close();
		String q1="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\",\"PARTNEREMAIL\",\"DATE\",\"SLOT\") VALUES('"+partnerEmail+"','"+myEmail+" wants to arrange a meeting with you on "+date+" at "+slot+"','"+myEmail+"','"+date+"','"+slot.replace('-', ',')+"')";
		con.createStatement().executeUpdate(q1);
		return 1;
		
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		}
		
	}
	public static int SchedulePresent(String email, String date, HttpServletRequest request) {
		
		try {
			createCon();
			String q="Select * from \"SCHEDULE\" where \"EMAIL\"='"+email+"' and \"DATE\"='"+date+"'";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(q);
			if(rs.next())
			{
				ScheduleBean.old=true;
				String availableHours=null;
				String freeSlots=null;
				String occupiedSlots=null;
				if(rs.getString(3)!=null) {
					availableHours=rs.getString(3).trim();
				}
				if(rs.getString(4)!=null) {
					freeSlots=rs.getString(4).trim();
				}
				if(rs.getString(5)!=null) {
					occupiedSlots=rs.getString(5).trim();
				}
				ScheduleBean sb=new ScheduleBean();
				sb.setEmail(email);
				sb.setDate(date);
				sb.setAvailableHours(availableHours);
				sb.setFreeSlots(freeSlots);
				sb.setOccupiedSlots(occupiedSlots);
				request.getSession().setAttribute("userSchedule", sb);
				return 1;
			}
			else
			{
				ScheduleBean.old=false;
				return 0;
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		
		
		return 0;
	}
	public static int fetchFreeSlots(String email, String date, HttpServletRequest request) {
		System.out.println(email+"**"+date+"**");
			try {
				createCon();
				String q="Select * from \"SCHEDULE\" where \"EMAIL\"='"+email+"' and \"DATE\"='"+date+"'";
				Statement st=con.createStatement();
				ResultSet rs=st.executeQuery(q);
				
				if(rs.next())
				{
					
					String availableHours=null;
					String freeSlots=null;
					String occupiedSlots=null;
					if(rs.getString(3)!=null) {
						availableHours=rs.getString(3).trim();
					}
					if(rs.getString(4)!=null) {
						freeSlots=rs.getString(4).trim();
					}
					if(rs.getString(5)!=null) {
						occupiedSlots=rs.getString(5).trim();
					}
					ScheduleBean sb=new ScheduleBean();
					sb.setEmail(email);
					sb.setDate(date);
					sb.setAvailableHours(availableHours);
					sb.setFreeSlots(freeSlots);
					sb.setOccupiedSlots(occupiedSlots);
					request.getSession().setAttribute("personSchedule", sb);
					return 1;
				}
				else
				{
					
					return 0;
				}
				
			} catch (ClassNotFoundException | SQLException e) {
			
				e.printStackTrace();
			}
			finally {
				try {
					close();
				} catch (SQLException e) {
					
					e.printStackTrace();
				}
			}
			
			
			return 0;
		}
	
	public static int updateSchedule(ScheduleBean sb) {
		try {
			createCon();
			String q="Select * from \"SCHEDULE\" where \"EMAIL\"='"+sb.getEmail()+"' and \"DATE\"='"+sb.getDate()+"'";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(q);
			if(rs.next())
			{
				// old entry present So update

				String query="UPDATE \"SCHEDULE\" set \"AVAILABLEHOURS\"='"+sb.getAvailableHours()+"',\"FREESLOTS\"='"+sb.getFreeSlots()+"',\"OCCUPIEDSLOTS\"='"+sb.getOccupiedSlots()+"' where \"EMAIL\"='"+sb.getEmail()+"' and \"DATE\"='"+sb.getDate()+"'";
				System.out.println(query);
				st.executeUpdate(query);
				System.out.println("Update Success");
				return 1;
				
			}
			else
			{
				// No old entry So insert
				String query="INSERT  INTO   \""+"SCHEDULE"+"\" (\"EMAIL\",\"DATE\",\"AVAILABLEHOURS\",\"FREESLOTS\",\"OCCUPIEDSLOTS\") values(?,?,?,?,?)";
				PreparedStatement psmt=con.prepareStatement(query);
				
				psmt.setString(1,sb.getEmail());
				psmt.setString(2,sb.getDate());
				psmt.setString(3,sb.getAvailableHours());
				psmt.setString(4,sb.getFreeSlots());
				psmt.setString(5,sb.getOccupiedSlots());
				
				psmt.executeUpdate();
				System.out.println("New Entry Insert Success");
			}
			return 1;
			
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
			
				e.printStackTrace();
			}
		}
	}
	public static int acceptMeetingFriendRequest(String email, String requestEmail, String date, String slot) {
		try {
			createCon();
			String q="Select * from \"SCHEDULE\" where \"EMAIL\"='"+email+"' and \"DATE\"='"+date+"'";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(q);
			if(!rs.next()) {
				return -1;   //entry not exist
			}

			String slots=null;
			slots=rs.getString(4);
			System.out.println(slots);
			slots=slots.replace(slot,"@");
			boolean slotExist=false;
			for(int i=0;i<slots.length();i++)
			{
				if(slots.charAt(i)=='@')
				{
					slotExist=true;
					slots=slots.substring(0,i)+slots.substring(i+1);
					break;
					
				}
			}
			//removing commas
			for(int i=0;i<slots.length();i++)
			{
				if(slots.charAt(i)==',') 
					{
					if((i+1)>=slots.length()) 
					{
						slots=slots.substring(0,i+1);
					}
					else if(slots.charAt(i+1)==',')
					slots=slots.substring(0,i)+slots.substring(i+1);
					else if(i==0)
						slots=slots.substring(1);
				}
			}
			if(!slotExist) {
				
				return -1;   //slot not exist
			}
			String q1="DELETE FROM  \"NOTIFICATIONS\" where \"EMAIL\" = '"+email+"' and \"PARTNEREMAIL\" = '"+requestEmail+"' and \"DATE\"='"+date+"' and \"SLOT\"='"+slot+"'";
			con.createStatement().executeUpdate(q1);
			
			String q2="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\") VALUES('"+requestEmail+"','"+email+" has accepted your meeting request of "+date+" at "+slot.replace(',','-')+". You can get the Room id and password in My Meetings Tab.')";
			con.createStatement().executeUpdate(q2);
			
			String q3="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\") VALUES('"+email+"','You have accepted "+requestEmail+" meeting request of "+date+" at "+slot.replace(',','-')+". You can get the Room id and password in My Meetings Tab.')";
			con.createStatement().executeUpdate(q3);
							//slot exist and removed
				// Now adding it to occupied slots
				String OccupiedSlots=null;
				String requestOccupiedSlots=null;
				
				OccupiedSlots=rs.getString(5).trim();
				String q4="Select * from \"SCHEDULE\" where \"EMAIL\"='"+requestEmail+"' and \"DATE\"='"+date+"'";
				rs.close();
				ResultSet rs2=st.executeQuery(q4);
				
				if(rs2.next())
				{
					requestOccupiedSlots=rs2.getString(5).trim();
				}else {
					String query="INSERT  INTO   \"SCHEDULE\" (\"EMAIL\",\"DATE\")  VALUES(?,?)";
					 PreparedStatement psmt=con.prepareStatement(query);
						psmt.setString(1,requestEmail);
						psmt.setString(2, date);
						psmt.executeUpdate();
						
					requestOccupiedSlots="";
				}
				
				if(OccupiedSlots.length()>0)
					OccupiedSlots+=","+slot.replace('-',',');
				else {
					OccupiedSlots+=slot.replace('-',',');				
				}
				if(requestOccupiedSlots.length()>0)
					requestOccupiedSlots+=","+slot.replace('-',',');
				else {
					requestOccupiedSlots+=slot.replace('-',',');				
				}
				System.out.println(OccupiedSlots);
				
				//Update schedule table
				
				String updateQ1="UPDATE  \"SCHEDULE\" SET  \"FREESLOTS\" = '"+slots+"', \"OCCUPIEDSLOTS\" = '"+OccupiedSlots+"'   WHERE \"EMAIL\" = '"+email+"' and \"DATE\" = '"+date+"'";
				
				String updateQ2="UPDATE  \"SCHEDULE\" SET  \"OCCUPIEDSLOTS\" = '"+requestOccupiedSlots+"'   WHERE \"EMAIL\" = '"+requestEmail+"' and \"DATE\" = '"+date+"'";
				st.executeUpdate(updateQ1);
				st.executeUpdate(updateQ2);
				//--------------My Meetings-----------------------
				
				rs2.close();
				String q5="Select COUNT(*) from \"MEETINGDATA\"";
				ResultSet set=st.executeQuery(q5);
				set.next();
				int roomId = Integer.parseInt(set.getString(1).trim())+100000;
				
				//Password Generation

			    int leftLimit = 97; // letter 'a'
			    int rightLimit = 122; // letter 'z'
			    int targetStringLength = 6;
			    Random random = new Random();
			    StringBuilder buffer = new StringBuilder(targetStringLength);
			    for (int i = 0; i < targetStringLength; i++) {
			        int randomLimitedInt = leftLimit + (int) 
			          (random.nextFloat() * (rightLimit - leftLimit + 1));
			        buffer.append((char) randomLimitedInt);
			    }
			    String password = buffer.toString();
			 
			    System.out.println(roomId+"--"+password);
				
			    String updateMeetingsQ1="INSERT INTO  \"MEETINGDATA\" (\"EMAIL\",\"PARTNEREMAIL\",\"DATE\",\"STARTINGTIME\",\"ENDINGTIME\",\"ROOMID\",\"PASSWORD\") VALUES (?,?,?,?,?,?,?)";
			    PreparedStatement psmt=con.prepareStatement(updateMeetingsQ1);
				psmt.setString(1,email);
				psmt.setString(2, requestEmail);
				psmt.setString(3, date);
				String time[]=slot.split(",");
				psmt.setString(4,time[0]);
				psmt.setString(5,time[1]);
			    psmt.setString(6,Integer.toString(roomId));
			    psmt.setString(7,password);
			    psmt.executeUpdate();
			    
			    String updateMeetingsQ2="INSERT INTO  \"MEETINGDATA\" (\"EMAIL\",\"PARTNEREMAIL\",\"DATE\",\"STARTINGTIME\",\"ENDINGTIME\",\"ROOMID\",\"PASSWORD\") VALUES (?,?,?,?,?,?,?)";
			    psmt=con.prepareStatement(updateMeetingsQ2);
				psmt.setString(1,requestEmail);
				psmt.setString(2, email);
				psmt.setString(3, date);
				psmt.setString(4,time[0]);
				psmt.setString(5,time[1]);
			    psmt.setString(6,Integer.toString(roomId));
			    psmt.setString(7,password);
			    psmt.executeUpdate();
			    
			    System.out.println("Accepted Success");
				
			    return 1;
			
			
			
			
			
			}
			catch(Exception e) {
				e.printStackTrace();
				return 0;
			}
			finally {
				try {
					close();
				} catch (SQLException e) {
					
					e.printStackTrace();
				}
				
			}
			
		
	}
	public static int rejectMeetingFriendRequest(String email, String requestEmail, String date, String slot) {
		System.out.println("Rejecting");
		System.out.println(email+"--"+date+"--"+slot+"--"+requestEmail);
		try {
		createCon();
		String q1="DELETE FROM  \"NOTIFICATIONS\" where \"EMAIL\" = '"+email+"' and \"PARTNEREMAIL\" = '"+requestEmail+"' and \"DATE\"='"+date+"' and \"SLOT\"='"+slot+"'";
		con.createStatement().executeUpdate(q1);
		
		String q2="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\") VALUES('"+requestEmail+"','"+email+" has rejected your meeting request of "+date+" at "+slot.replace(',','-')+"')";
		con.createStatement().executeUpdate(q2);
		
		String q3="INSERT INTO   \"NOTIFICATIONS\" (\"EMAIL\",\"NOTIFICATION\") VALUES('"+email+"','You have rejected "+requestEmail+" meeting request of "+date+" at "+slot.replace(',','-')+"')";
		con.createStatement().executeUpdate(q3);
				
		
		System.out.println("Rejected Success");
		return 1;
		
		}
		catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			try {
				close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		}
		
	}
	
	
	
}



// SQL

//CREATE TABLE USERDATA ( FNAME CHAR(10) NOT NULL ,LNAME CHAR(10) NOT NULL ,EMAIL CHAR(35) NOT NULL ,USERNAME CHAR(25) NOT NULL ,PASSWORD CHAR(45) NOT NULL ,DATEOFBIRTH CHAR(10) NOT NULL ,GENDER CHAR(6) NOT NULL ,COMPANY CHAR(30) NOT NULL ,CONTACT CHAR(10) NOT NULL ,PROFILEPICTURE BLOB(1048576) NOT NULL ,COVERPICTURE BLOB(1048576) ) ;    
//CREATE TABLE FRIENDREQUESTS ( EMAIL CHAR(35) NOT NULL ,REQUESTEMAIL CHAR(35) NOT NULL ) ;
//CREATE TABLE NOTIFICATIONS ( EMAIL CHAR(35) NOT NULL ,NOTIFICATION CHAR(200) NOT NULL ,PARTNEREMAIL CHAR(35),DATE CHAR(250) ,SLOTS CHAR(250)  ) ;
//CREATE TABLE FRIENDLIST( EMAIL CHAR(35) NOT NULL,FRIENDEMAIL CHAR(35) NOT NULL ) ;
//CREATE TABLE MEETINGDATA ( EMAIL CHAR(35) NOT NULL ,PARTNEREMAIL CHAR(35) NOT NULL ,DATE CHAR(15) NOT NULL ,STARTINGTIME CHAR(10) NOT NULL ,ENDINGTIME CHAR(10) NOT NULL ,ROOMID CHAR(100) NOT NULL ,PASSWORD CHAR(100) NOT NULL )  ;
//CREATE TABLE SCHEDULE ( EMAIL CHAR(35) NOT NULL ,DATE CHAR(15) NOT NULL ,AVAILABLEHOURS CHAR(30) ,FREESLOTS CHAR(250) ,OCCUPIEDSLOTS CHAR(250) ) ;
//CALL SYSPROC.ADMIN_CMD('REORG TABLE USERDATA');
//CALL SYSPROC.ADMIN_CMD('REORG TABLE SCHEDULE');
//CALL SYSPROC.ADMIN_CMD('REORG TABLE NOTIFICATIONS');
//CALL SYSPROC.ADMIN_CMD('REORG TABLE FRIENDREQUESTS');
//CALL SYSPROC.ADMIN_CMD('REORG TABLE FRIENDLIST');
//CALL SYSPROC.ADMIN_CMD('REORG TABLE MEETINGDATA');