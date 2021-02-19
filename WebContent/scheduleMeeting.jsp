<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.database.*,java.sql.*"%>
     <% 
    ScheduleBean sb=(ScheduleBean) session.getAttribute("personSchedule");

    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Meeting</title>
    
    <!-- Materlize CSS -->
    <link rel="stylesheet" href="css/materialize.min.css">
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="ss.css">
    
    <!-- Materialize JavaScript -->
   <script src="js/materialize.min.js"></script>

    <!-- Jquery for inbuilt functions -->
    <script src="jq/jquery-3.5.1.min.js" type="text/javascript"></script>
    
    <!-- For Icons  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
      
        .Button{    
      background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
      height: 7vh;
      width: 22.5vh;
      position: relative;
      border-radius: 1.0rem;
      left: 1.8vh;
      color:white;
      font-size: 3vh;
      outline: none;
      }
      .Button:hover
      {
           background:linear-gradient(90deg, rgb(20, 13, 156) 0%, rgb(5, 11, 77) 20%, rgb(78, 32, 116) 100%);
      }
      .disabled{
  
  color:rgb(0, 0, 0);
  background: linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(0,19,121,1) 100%, rgba(140,0,255,1) 100%);
  }
  
  .friendRow{
  background-color:white;
 
  }
  .friendRow:hover{
  background-color:rgb(240,240,240);
  }
  
  
    .loader {
        position: relative;
        top:130px;
        
        left: 150px;
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
    function resetAll(){

    	window.location.href="resetSchedule2";
    }
    </script>
      <script>
function viewProfile(str){
	$("#friendList").hide();
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
            $("#friendList").show();
            $("#myLbl").show();
            $(".loaderMsg").hide();
          }
          else
        	  {
        	  window.location="500error";
        	  $("#friendList").show();
        	  $("#myLbl").show();
        	  $(".loaderMsg").hide();
        	  }

      },
      error:function(jqXHR,textStatus,errorThrown){  
             window.location="500error";
             $("#friendList").show();
             $("#myLbl").show();
             $(".loaderMsg").hide();
      }
      

    })
}

function insertProfile(email){
$("#email").val(email);
}
function insertSlot(time){
	$("#slotField").val(time);
	}


$(document).ready(function()                     // Jquery
        {
$("#emailForm").on('submit',function(event){
	console.log("hello");
	 $("#notPresentLbl").hide();
     
    event.preventDefault();        

var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/;
if(document.forms["emailForm"]["email"].value==""){
    alert("Email can not be empty");
return false;
}
else if(document.forms["emailForm"]["email"].value.match(mailformat))
{

}
else
{
alert("You have entered an invalid email address!");
return false;
}




//--------------------------------------------------------------


              document.getElementById("submitBtn").disabled=true;
              document.getElementById("resetBtn").disabled=true;
              $("#submitBtn").addClass("disabled");
              $("#resetBtn").addClass("disabled");
              // serialize -----------FormData
              //  textutual-----------textual+binary images clobs blobs
               var f=$(this).serialize(); 


              $.ajax({
                url:"fetchSlotsServlet",
                data:f,
                type:'POST',
                
                success:function(data,textStatus,jqXHR){
                	//---------
                  if(data.trim()=="Success"){
					
                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;
                      $("#submitBtn").removeClass("disabled");
                      $("#resetBtn").removeClass("disabled");

                	  
                    window.location="scheduleMeeting";
                  }
                  else if(data.trim()=="NotPresent"){
                	  document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;
                      $("#submitBtn").removeClass("disabled");
                      $("#resetBtn").removeClass("disabled");
					
                      $("#notPresentLbl").show();
                    
                  }
                  else{

                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;
                      $("#submitBtn").removeClass("disabled");
                      $("#resetBtn").removeClass("disabled");
                    window.location="500error";
                  }

                },
                error:function(jqXHR,textStatus,errorThrown){

                  document.getElementById("submitBtn").disabled=false;
                  document.getElementById("resetBtn").disabled=false;
                  $("#submitBtn").removeClass("disabled");
                  $("#resetBtn").removeClass("disabled");
                  window.location="500error";
                },
               
              });

        });
       
var freeSlotsArr=[];
<%
if(sb!=null&&sb.getFreeSlots()!=null){
	   for(String slot:sb.getFreeSlots().split(","))
		   {
		   %>
		   freeSlotsArr.push(<%="\""+slot+"\""%>);
		   <%
		   }
}
%>
  
$(function(){
	var numFree=1; 
	
 for(var i=0;i<freeSlotsArr.length-1;i+=2){
   $('#freeRecords').append('<tr class="friendRow" onclick="insertSlot(\''+freeSlotsArr[i]+"-"+freeSlotsArr[i+1]+'\')">' +
'<td style="width:20%">' + numFree++ + '</td>' +
 '<td style="width:40%">' + freeSlotsArr[i] + '</td>' +
 '<td style="width:40%;">' + freeSlotsArr[i+1] + '</td>' +
 '</tr>');
 }
 
 var f="array="+freeSlotsArr;
 console.log(f);


});
        });
</script> 
</head>
<body>
        
       <%@include file="index.jsp" %>
	<%!
	int i=1;
	ResultSet rs=null;
	%>
	<%

	rs=Database.getFriendList(user.getEmail());
	%>
	<script>
	
	function submitAllData(){
		$("#successLbl").hide();
		var email=document.getElementById("email").value;
		var slot=document.getElementById("slotField").value
		var userEmail=<%="\""+user.getEmail()+"\""%>;
		var date=document.getElementById("date").value;
		
		//--------------------------------------------------------------
if(email==""||slot==""||userEmail==""||date=="")
	{
	alert("Fill all fields");
	return false;
	}
	
		              document.getElementById("submitAllBtn").disabled=true;
		           
		              $("#submitAllBtn").addClass("disabled");
		           
		               var f="partnerEmail="+email+"&&email="+userEmail+"&&date="+date+"&&slot="+slot; 
		               


		              $.ajax({
		                url:"setupMeeting",
		                data:f,
		                type:'POST',
		                
		                success:function(data,textStatus,jqXHR){
		                	//---------
		                  if(data.trim()=="Success"){
							//show success msg
							$("#successLbl").show();
							  document.getElementById("submitAllBtn").disabled=false;
							  $("#submitAllBtn").removeClass("disabled");
		                    window.location="resetSchedule2";
		                  }
		                  if(data.trim()=="AlreadySent"){
								
								  document.getElementById("submitAllBtn").disabled=false;
								  $("#submitAllBtn").removeClass("disabled");
								  alert("Request for this slot has already sent");
			                    
			                  }
		                  else{
		                	  document.getElementById("submitAllBtn").disabled=false;
		                      
		                      $("#submitAllBtn").removeClass("disabled");
		                					
		                     
		                    
		                  }
		                 
		                },
		                error:function(jqXHR,textStatus,errorThrown){

		                  document.getElementById("submitBtn").disabled=false;
		                  document.getElementById("resetBtn").disabled=false;
		                  $("#submitBtn").removeClass("disabled");
		                  $("#resetBtn").removeClass("disabled");
		                  window.location="500error";
		                },
		               
		              });
	}

	</script>


      
        

        <div class="availability" style="border:0px;width: 81.74vw;height:91vh;position: relative;left: 18.25vw;top:8.8vh;background: rgba(0,0,0,0.7) url(img/bg5.jpg);background-blend-mode: darken;background-size: cover;opacity: 0.89;">
                
          
          <div class="dateDiv" style="background-color:white;height:fit-content;box-shadow:1px 1px 6px 1px;width:33vw;position: relative;left: 47.5%;top:5%;border-radius: 10px;" class=loginDiv>
            <form name="emailForm" action="" id="emailForm">
              <label style="font-size: 3vh;color: rgb(37, 36, 36);font-weight: 700;position:relative;left: 6%;top:1vh;" >Select your Partner Email from Friend List</label>
           <br> 
            <input style="font-size:1.2vw;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 45%;height:7vh;padding-left: 5%;margin-left: 5%;margin-top: 2%;" type="text" placeholder="Friend Email" name="email" id="email" readonly="true" required>
            <button class="Button" type="submit" id="submitBtn" style="width: fit-content;padding:10px">Fetch Free Slots</button>
            
            <br>
            <input style="font-size:1.2vw;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 45%;height:7vh;padding-left: 5%;margin-left: 5%;margin-top: 2%;" type="date" placeholder="Friend Email" name="date" id="date" required>
            
            <button class="Button" id="resetBtn" onclick="javascript:resetAll()" type="button" style="width: 8vw;padding-left: 15px;padding-right:15px;margin-left: 3.5vh;" >Reset</button>
            </form>
            <label id="successLbl" hidden="true" style="font-size: 3.5vh;color:rgb(9, 182, 9);position:relative;left: 13%;top:0vh;">Meeting request sent successfully</label>
            <label id="notPresentLbl" hidden="true" style="font-size: 3.5vh;color:red;position:relative;left: 13%;top:0vh;">Schedule Not Uploaded for this date</label>
          </div> 
                
          
                         

                
        
        <style>
               table{margin:10px;display:block;}
        </style>
        <%
    if(sb!=null){
	
    if(sb.getFreeSlots()!=null){
    %>
    <script>
    $("#date").prop("readonly",true);
    $("#date").val(<%="\""+sb.getDate()+"\""%>);
    $("#email").prop("readonly",true);
    $("#email").val(<%="\""+sb.getEmail()+"\""%>);
    </script>
    <%	
    }
    
    }
        if(sb!=null){
        %>
        <div class="selectedDiv" style="background-color:white;height:fit-content;box-shadow:1px 1px 6px 1px;width:13vw;position: relative;left: 77%;top:20%;border-radius: 10px;" class=loginDiv>
            
              <label style="font-size: 3vh;color: rgb(37, 36, 36);font-weight: 700;position:relative;left: 12%;top:1vh;" >Selected Slot</label>
           <br> 
            <input style="font-size:1.2vw;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 80%;height:7vh;padding-left: 5%;margin-left: 5%;margin-top: 2%;" type="text" placeholder="  Ex-11:00-12:00" name="slotField" id="slotField" readonly="true">
            
             </div> 
        <div style="background-color:white;height:58%;box-shadow:1px 1px 6px 1px;width:18%;position: absolute;top:40%;right:30%;border-radius: 10px;">
                <label  style="font-size: 3.5vh;font-weight:700;color:black;position:relative;left: 25%;top:1vh;">Free Slots</label>
                <hr style="margin-top: 1.5vh;width: 90%;left: 5%;position: relative;">
                <table id="freeRecords" style="font-size:3vh;overflow:scroll;overflow-x: hidden;height:80%;">
                  <tr>
                  <th  style="width: 20px;">#</th>
                  <th style="width: 150px;position: relative;left: 0px;">From</th>
                  <th style="width: 150px;position: relative;left: 10px;">To</th>
                </tr>
               
                
                
                </table>
                <button class="Button" id="submitAllBtn" type="button" onclick="javascript:submitAllData()" style="position: absolute;left: 20vw;height: fit-content;padding:10px;width: fit-content;top:48%;"  >Send Meeting Request</button>
  


            
            
        </div>
        <%
        }
        %>
        <div class="friendListClass">

<style>
      table{margin:10px;display:block;}
</style>
                        <div style="background-color:white;height:90%;box-shadow:1px 1px 6px 1px;width:40%;position: absolute;top:4%;left: 4%;border-radius: 10px;">
                        <label  style="font-size: 3.5vh;font-weight:700;color:black;position:relative;left: 37%;top:1vh;">Friend List</label>
                        <hr style="margin-top: 1.5vh;width: 90%;left: 5%;position: relative;">
                        <table id="friendList" style="font-size:3vh;overflow:scroll;overflow-x: hidden;height:88%;">
                          <tr>
                          <th  style="width: 10%;">#</th>
                          <th style="width:40%;position: relative;left: 12px;">Username</th>
                          <th style="width: 50%;position: relative;left: 90px;">Email</th>
                        </tr>
                       	 <%
         if(rs!=null){
         while(rs.next()){
         %>
          <tr class="friendRow" onclick="javascript:insertProfile<%="('"+rs.getString(1).trim()+"')"%>">
            <th scope="row" ><%=i++ %></th>
             <td><a href="#" onclick="javascript:viewProfile<%="('"+rs.getString(1).trim()+"')"%>"><%=rs.getString(2) %></a></td>
            <td><%=rs.getString(1) %></td>
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
                        
                       
                        
                        
                        </table>
                        <div class="loaderMsg" hidden=true style="z-index:10;">
      		
            <div class="loader">   
            </div>
            <br>
            <label style="font-size:20px;color:black;position:relative;left:196px;top:120px;">Please Wait...</label>
            </div>
        
                        </div>
        
   </div>


             

           <script>
          $(function(){
          $("#mainIndexImport").load("index.html"); 
        });</script>

</body>

</html>