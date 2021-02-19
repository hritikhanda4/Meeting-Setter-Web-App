<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
    <style>
    .loader {
        position: relative;
        top:150px;
        
        left: 780px;
  border: 16px solid #f3f3f3; /* Light grey */
  border-top: 16px solid #3498db; /* Blue */
  border-radius: 100%;
  width: 200px;
  height: 200px;
  animation: spin 2s linear infinite;
  z-index:10;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    </style>
</head>
<body>
<%@include file="index.jsp" %>
    <div class=container style="width:1238px; height: 720px; position:absolute;left:280px;top:0px;background-color: rgb(240, 240, 240);">
    <label style="color: black;font-size: 25px;position: relative;left: 500px;top: 80px;" id="myLbl">Friend Requests</label>
        
    </div>

    
    <div id="mainIndexImport">

    </div>
	<%!
	int i=1;
	ResultSet rs=null;
	%>
	<%
	rs=Database.getFriendRequests(user.getEmail());
	%>
	
	
    <table id="table" class="table" style="position: relative;left: 19rem;top: 8rem;width:83.39rem;vertical-align: middle;">
        
          <tr style="vertical-align: middle;width:9em;border-radius:25px;background-color:rgb(51, 48, 48);color:white;">
            <th scope="col" >#</th>
            <th scope="col">Email</th>
            <th scope="col">Username</th>
             <th scope="col">Date of Birth</th>
            <th scope="col">Gender</th>
            <th scope="col">Company</th>
            <th scope="col">Contact</th>
            <th scope="col" style="width:4em">Accept</th>
            <th scope="col" style="width:4em">Reject</th>
          </tr>
        
       
        <tbody style="vertical-align: middle;">
         
         <%
         if(rs!=null){
         while(rs.next()){
         %>
          <tr>
            <th scope="row" ><%=i++ %></th>
            <td><a href="#" onclick="javascript:viewProfile<%="('"+rs.getString(1).trim()+"')"%>"><%=rs.getString(1) %></a></td>
            <td><%=rs.getString(2) %></td>
            <td><%=rs.getString(3) %></td>
            <td><%=rs.getString(4) %></td>
            <td><%=rs.getString(5) %></td>
            <td><%=rs.getString(6) %></td>
            <td><a href="#" onclick="javascript:acceptRequest('a<%=i-1 %>','<%=user.getEmail()+"','"+rs.getString(1).trim()+"')"%>"><img id="a<%=i-1 %>" style="border-radius:25px;max-width:80%" src="img/tick.jpg"></img></a></td>
          	<td><a href="#" onclick="javascript:rejectRequest('a<%=i-1 %>','<%=user.getEmail()+"','"+rs.getString(1).trim()+"')"%>"><img id="a<%=i-1 %>" style="border-radius:25px;max-width:80%" src="img/cross.jpg"></img></a></td>
          
          </tr> 
          
          <%
         }
         }
         i=1;
         try {
				Database.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
          %>
        </tbody>
      </table>
      		<div class="loaderMsg" hidden=true style="z-index:10;">
      		
            <div class="loader">   
            </div>
            <br>
            <label style="font-size:20px;color:black;position:relative;left:820px;top:140px;">Please Wait...</label>
            </div>
      


<script>
function acceptRequest(id,myEmail,targetEmail){
	var f="id="+id+"&&myEmail="+myEmail+"&&requestEmail="+targetEmail;
	console.log(f);
	$("#table").hide();
	$("#myLbl").hide();
	$(".loaderMsg").show();

	console.log(f);
    $.ajax({
      url:"acceptRequest",
      data:f,
      type:'POST',
      success:function(data,textStatus,jqXHR){
          if(data.trim()=="Success")
          {  
        	window.location="friendRequests.jsp";
 
            $(".loaderMsg").show();
          }
          else
        	  {
        	  window.location="500error";
        	  $("#table").show();
        	  $("#myLbl").show();
        	  $(".loaderMsg").hide();
        	  }

      },
      error:function(jqXHR,textStatus,errorThrown){  
             window.location="500error";
             $("#table").show();
             $("#myLbl").show();
             $(".loaderMsg").hide();
      }
      

    })
	
}
function rejectRequest(id,myEmail,targetEmail){
	var f="id="+id+"&&myEmail="+myEmail+"&&requestEmail="+targetEmail;
	console.log(f);
	$("#table").hide();
	$("#myLbl").hide();
	$(".loaderMsg").show();

	console.log(f);
    $.ajax({
      url:"rejectRequest",
      data:f,
      type:'POST',
      success:function(data,textStatus,jqXHR){
          if(data.trim()=="Success")
          {  
        	window.location="friendRequests.jsp";
            
            $(".loaderMsg").show();
          }
          else
        	  {
        	  window.location="500error";
        	  $("#table").show();
        	  $("#myLbl").show();
        	  $(".loaderMsg").hide();
        	  }

      },
      error:function(jqXHR,textStatus,errorThrown){  
             window.location="500error";
             $("#table").show();
             $("#myLbl").show();
             $(".loaderMsg").hide();
      }
      

    })
	
}

function viewProfile(str){
	$("#table").hide();
	$("#myLbl").hide();
	$(".loaderMsg").show();
	
    var f="email="+str;
	console.log(f);
    $.ajax({
      url:"viewProfileServlet",
      data:f,
      type:'POST',
      success:function(data,textStatus,jqXHR){
          if(data.trim()=="Success")
          {  
            window.location="viewProfile"; 
            $("#table").show();
            $("#myLbl").show();
            $(".loaderMsg").hide();
          }
          else
        	  {
        	  window.location="500error";
        	  $("#table").show();
        	  $("#myLbl").show();
        	  $(".loaderMsg").hide();
        	  }

      },
      error:function(jqXHR,textStatus,errorThrown){  
             window.location="500error";
             $("#table").show();
             $("#myLbl").show();
             $(".loaderMsg").hide();
      }
      

    })
}


</script> 


</body>


</html>