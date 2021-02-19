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
    <script>
    function acceptMeetingRequest(requestEmail,email,date,slot){
    	var f="email="+email+"&&date="+date+"&&partnerEmail="+requestEmail+"&&slot="+slot;
    	console.log(f);
    	$("#table").hide();
    	$("#myLbl").hide();
    	$(".loaderMsg").show();

    	console.log(f);
        $.ajax({
          url:"acceptMeetingRequest",
          data:f,
          type:'POST',
          success:function(data,textStatus,jqXHR){
              if(data.trim()=="Success")
              { 
            	  $("#table").show();
          	 	 $("#myLbl").show();
                 $(".loaderMsg").hide();
            	window.location="notifications";
            	
              }
              else if(data.trim()=='DuplicateAccepted')
            	  {
            	  
            	  $("#table").show();
           	 	 $("#myLbl").show();
                  $(".loaderMsg").hide();
                  alert("Same Slot Request has already accepted..or Free Slot not exist");
                  
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
                 
                 $("#table").show();
                 $("#myLbl").show();
                 $(".loaderMsg").hide();
                 window.location="500error";
          }
          

        })
    	
    }
    function rejectMeetingRequest(requestEmail,email,date,slot){
    	var f="email="+email+"&&date="+date+"&&partnerEmail="+requestEmail+"&&slot="+slot;
    	console.log(f);
    	$("#table").hide();
    	$("#myLbl").hide();
    	$(".loaderMsg").show();

    	console.log(f);
        $.ajax({
          url:"rejectMeetingRequest",
          data:f,
          type:'POST',
          success:function(data,textStatus,jqXHR){
              if(data.trim()=="Success")
              {  
            	window.location="notifications";
            	$("#table").show();
          	 	 $("#myLbl").show();
                $(".loaderMsg").hide();
              }
              else
            	  {
            	  
            	  $("#table").show();
            	  $("#myLbl").show();
            	  $(".loaderMsg").hide();
            	  window.location="500error";
            	  }

          },
          error:function(jqXHR,textStatus,errorThrown){  
                 $("#table").show();
                 $("#myLbl").show();
                 $(".loaderMsg").hide();
                 window.location="500error";
          }
          

        })
    	
    }
    
    
    </script>
</head>
<body>
<%@include file="index.jsp" %>
    <div class=container style="width:1238px; height: 720px; position:absolute;left:280px;top:0px;background-color: rgb(240, 240, 240);">
    <label style="color: black;font-size: 25px;position: relative;left: 500px;top: 80px;" id="myLbl">Notifications</label>
        
    </div>

    
    <div id="mainIndexImport">

    </div>
	<%!
	int i=1;
	ResultSet rs=null;
	%>
	<%

	rs=Database.getNotifications(user.getEmail());
	%>
	
	
    <table id="table" class="table" style="position: relative;left: 19rem;top: 8rem;width:83.39rem;vertical-align: middle;">
        
          <tr style="vertical-align: middle;width:9em;border-radius:25px;background-color:rgb(51, 48, 48);color:white;">
            <th scope="col" >#</th>
            <th scope="col">Notification</th>
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
            <td><%=rs.getString(2) %></td>
            <%
            if(rs.getString(3)!=null){
            %>
           <td><a href="#" onclick="javascript:acceptMeetingRequest('<%=rs.getString(3).trim() %>','<%=user.getEmail()+"','"+rs.getString(4).trim()+"','"+rs.getString(5).trim()+"')"%>"><img  style="border-radius:25px;max-width:80%" src="img/tick.jpg"></img></a></td>
          	<td><a href="#" onclick="javascript:rejectMeetingRequest('<%=rs.getString(3).trim() %>','<%=user.getEmail()+"','"+rs.getString(4).trim()+"','"+rs.getString(5).trim()+"')"%>"><img style="border-radius:25px;max-width:80%" src="img/cross.jpg"></img></a></td>
          <%
            }
            else{
          %>
          <td></td>
          <td></td>
          <%
            }
          %>
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
      		
</body>


</html>