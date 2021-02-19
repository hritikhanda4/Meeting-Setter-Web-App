<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.database.*,java.io.*,java.sql.*" %>
    
    <%@include file="index.jsp" %>
    
  <%
  UserBean person=(UserBean) session.getAttribute("userProfile");
  
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    
    <!-- Materlize CSS -->
    <link rel="stylesheet" href="css/materialize.min.css">
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/myProfile.css">
    
    <!-- Materialize JavaScript -->
   <script src="js/materialize.min.js"></script>

    <!-- Jquery for inbuilt functions -->
    <script src="jq/jquery-3.5.1.min.js" type="text/javascript"></script>
    
    <!-- For Icons  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <style>
    
.detailsLabel{
    display: block; width: 260px;
   /* // background-color: rgb(187, 175, 238); */
    /* border:1px black solid; */
    border-radius: 7px;
    color: black;
    
    padding: 10px;
    font-size: 18px;
    text-align: left;
    
}

#element{
 position: relative;
 left: 0px;
 padding-left: 25px;
 width:1235px;
 /* border:2px red solid; */
 top:10px;
}
#change{
    position: relative;
 top:6px;
 } 
</style>
  
</head>
<body>
	
    <div class="mainContent">
       
        <div id="coverPhoto">
         
 
              <a href="myCover">
                   <img width=100% height=400px src=<%=("resources/"+person.getEmail().trim()+"Cover.jpg")%>>
               </a>
       </div>
       
       <div id="dp" style="position: absolute; left: 510px; top:190px;">
           <a href="myImage">
          
           <img width="200" height= "200"  class="circle" src=<%=("resources/"+person.getEmail().trim()+"Profile.jpg")%>>
           </a>
              
       </div>
       
       <div style="background-color:rgba(241, 239, 239, 0.897);padding: 20px;">
        <h5>General Account Settings</h5>
        <hr>
        <table>
            <tr >
               <td width=250px>
                    <label class="detailsLabel">First Name</label>
               </td>
                <td width=250px>
                    <label class="detailsLabel"><%=person.getFname() %></label></td>
                <td width=750px>
                   
                </td>
                <td>
                   
                </td>
            </tr>
            
              
            <tr>
                <td>
                    <label class="detailsLabel">Last Name</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=person.getLname() %></label>
                </td>
                <td>
                  
                </td>
                <td>
                   
                </td>
            </tr>

             <tr>
                 <td>
                     <label class="detailsLabel">Email</label>
                </td>
                <td>
                
                
                    <label class="detailsLabel"><%=person.getEmail()%></label>
                </td>
                <td>
                  
                </td>
                <td>
                </td>
                   
            </tr>
            <tr>
                <td>
                    <label class="detailsLabel">Date of Birth</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=person.getDateOfBith() %></label>
                </td>
                <td>
                    
                </td>
                <td>
                </td>
                  
            </tr>
            <tr>
                <td>
                    <label class="detailsLabel">Gender</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=person.getGender() %></label>
                </td>
                <td>
                  
                </td>
                <td>
                </td>
                    
            </tr>

             <tr>
                <td>
                    <label class="detailsLabel">Company</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=person.getCompany() %></label>
                </td>
                <td>
                     
                </td>
                <td>
                    
                </td> 
            </tr>

             <tr>   
                <td>
                     <label class="detailsLabel">Contact</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=person.getContact() %></label>
                </td>
                <td>
                     
                </td>
                <td>
                   </td>
            </tr>
       
            
        </table>
       </div>
       </div>
</body>
</html>