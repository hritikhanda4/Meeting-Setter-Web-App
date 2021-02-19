<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.database.*,java.sql.*,java.io.*"%>
    <%
    UserBean user=(UserBean) session.getAttribute("userCurrent");
    
    %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meeting Setter Web App</title>
    
    <!-- Materlize CSS -->
    <link rel="stylesheet" href="css/materialize.min.css">
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    
    <!-- Materialize JavaScript -->
   <script src="js/materialize.min.js"></script>
   
    

    <!-- Jquery for inbuilt functions -->
    <script src="jq/jquery-3.5.1.min.js" type="text/javascript"></script>
    
    <!-- For Icons  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
</head>
<body>
<style>

i {
  font-size: 40px;
}

.icn-spinner {
  animation: spin-animation 0.5s infinite;
  display: inline-block;
  color: white;
}

@keyframes spin-animation {
  0% {
    transform: rotate(0deg);
  }
 
  100% {
    transform: rotate(359deg);
  }
}

</style>


    <div style="z-index:10;" class="header">
        <div  id="searchDiv">
            <img width="50" height= "50"  class="circle" src="img/icon.png">   
            <form action="search.jsp" style="margin:0px;padding:0px;">
            <input style="position:absolute;top:0vh;" id="searchField" name="content" type="text" required> 
           <button style="background-color:transparent;border:none;" id="searchBtn" type="submit"> <i class="material-icons">search</i></button>
            </form>
             
        </div> 

        <div  id="logoDiv">
            <label id="label">Meeting Setter Web App</label>
            <img id="logo" width="50" height= "50"  class="circle" src="img/logo.png">    
        </div> 
       
        <div id="userDiv"> 
      
        <a id="userImage" href="<%=("resources/"+user.getEmail().trim()+"Profile.jpg")%>"><img width="50" height= "50"  class="circle" src=<%=("resources/"+user.getEmail().trim()+"Profile.jpg")%>></a>
        <a id="userName" href="myProfile"> <%=user.getFname()+" "+user.getLname() %></a>
        
        <div class="dropdown1">
            <button class="dropbtn1" ><i class="material-icons">more_vert</i></button>
            <div class="dropdown-content1">
              <a href="forgetPassword"><i style="position: relative;top:7px;" class="material-icons">settings</i><label style="font-size: 17px;margin-left: 15px;color: black;">Change password</label></a>
              <hr style="margin: 0px;">
              <a href="logout"><i style="position: relative;top:7px;" class="material-icons">subdirectory_arrow_left</i><label style="font-size: 17px;margin-left: 15px;color: black;">Logout</label></a>
            </div>
        </div>

        </div>
    </div>



 

   
    <div class="navBar">
     <div class="navBtn">
        <a href="myMeetings" >
       
        <img width="50" height= "50"  class="circle" src="img/meetings.png"><span class="navTxt">My Meetings</span>
        
        </a>
        </div>
        <div class="navBtn">
        <a href="mySchedule.jsp" >
            
            <img width="50" height= "50"  class="circle" src="img/mySchedule.png"><span class="navTxt">My Schedule</span>
            
        </a>
        </div>
        <div class="navBtn">
        <a href="friendList.jsp" >
            
            <img width="50" height= "50"  class="circle" src="img/friends.png"><span class="navTxt">Friend List</span>
            
        </a>
        </div>
         <div class="navBtn">
        <a href="friendRequests.jsp">
           
            <img width="50" height= "50"  class="circle" src="img/requests.png"><span class="navTxt">Friend Requests</span>
            
        </a>
        </div>
         <div class="navBtn">
        <a href="notifications.jsp">
           
            <img width="50" height= "50"  class="circle" src="img/notification.png"><span class="navTxt">Notifications</span>
            
        </a>
        </div>
        <div class="navBtn">
        <a href="scheduleMeeting.jsp">
            
            <img width="50" height= "50"  class="circle" src="img/arrange.png"><span class="navTxt">Schedule New Meeting</span>
            
        </a>
        </div>
        <div  class="navBtn">
        <a href="joinMeeting">
            
            <img width="50" height= "50"  class="circle" src="img/join.png"><span class="navTxt">Join Meeting</span>
            
        </a>
        </div>
        
    </div>
 

    


</body>
</html>
