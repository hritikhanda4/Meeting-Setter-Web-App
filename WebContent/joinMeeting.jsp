<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Meeting</title>
    
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
    
    #processingIcon {
  font-size: 40px;
  color:black;
}

.icn-spinner {
  animation: spin-animation 0.5s infinite;
  display: inline-block;
}

@keyframes spin-animation {
  0% {
    transform: rotate(0deg);
  }
  50% {
    transform: rotate(60deg);
  }
  100% {
    transform: rotate(359deg);
  }
}
    
    
    
    </style>
</head>
<body>
<%@include file="index.jsp" %>
    <div class=container style="width:1238px; height: 720px; position:absolute;left:280px;top:0px;background-color: rgb(240, 240, 240);">
            <div class="joinMeeting" style="background-color:white;height:280px;box-shadow:1px 1px 6px 1px;width:420px;position: relative;left: 400px;top: 230px;border-radius: 10px;" class=loginDiv>
                    <form name="joinForm" action="" id="joinForm">
                    <i style="position: relative;left: 15px;top: 30px;font-size: 40px;" class="material-icons">perm_identity</i><input required style="position: relative;top:20px;left:20px;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 70%;height:50px;padding-left: 20px;" type="text" name="roomId" id="roomId" placeholder="Enter Room Code"><br>
                    <i style="position: relative;left: 15px;top: 40px;font-size: 40px;" class="material-icons">lock_outline</i> <input required style="position: relative;top:30px;left:20px;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 70%;height:50px;padding-left: 20px;" type="text" name="password" id="password" placeholder="Enter Password"><br>
                    <i id="camera" style="position: relative;left: 15px;top: 60px;font-size: 40px;" class="material-icons">camera_alt</i>
                    <i  hidden="true" id="processingIcon"  style="position: relative;left: 15px;top: 60px;font-size: 40px;" class="material-icons js-spin">rotate_right</i>
                    <button id="joinBtn" type="submit">Join</button>
                    <br><br><br> <label hidden="true" id="noLbl" style="position:relative;left:40px;top:10px;color:red;font-size:17px">Room Not Exist Or Password Not Matched</label>
                   
                    </form>
                    
            </div>   
    </div>
    <style>
    #joinBtn:hover
    {
         background:linear-gradient(90deg, rgb(20, 13, 156) 0%, rgb(5, 11, 77) 20%, rgb(78, 32, 116) 100%);
    }
    #joinBtn{
        background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
        height: 50px;
        width: 315px;
        position: relative;
        left: 23px;
        border-radius: 10px; 
        top: 50px;
        color:white;
        font-size: 20px;
        outline: none;
    }
    </style>
          
     <script>
        
        $(document).ready(function()                     // Jquery
                {

        	$('.js-spin').addClass('icn-spinner') //remove class to stop animation
                    $("#processingIcon").hide();
                    $("#camera").show();
                      $("#joinForm").on('submit',function(event){
                    	event.preventDefault();
                    	document.getElementById("joinBtn").disabled=true;
						$("#noLbl").hide();
						$("#processingIcon").show();
						$("#camera").hide();
                       
                    //-------------------Ajax reuqest----------------

                    var f=$(this).serialize();
					console.log(f);
                    $.ajax({
                      url:"joinMeetingServlet",
                      data:f,
                      type:'POST',
                      success:function(data,textStatus,jqXHR){
                          if(data.trim()=="Success")
                          {
                        	  
                            window.location="VidyoConnector.jsp";
                            $("#processingIcon").hide();
                            $("#camera").show();
                            document.getElementById("joinBtn").disabled=false;
                          }
                          else if(data.trim()=="RoomNotExistOrPasswordNotMatched")
                          {
                        	  $("#noLbl").show();
                        	  $("#processingIcon").hide();
                        	  $("#camera").show();
                        	  document.getElementById("joinBtn").disabled=false;
                          }
                          else
                        	  {
                        	  window.location="500error";
                        	  $("#processingIcon").hide();
                        	  $("#camera").show();
                        	  document.getElementById("joinBtn").disabled=false;
                        	  }

                      },
                      error:function(jqXHR,textStatus,errorThrown){  
                             window.location="500error";
                             $("#processingIcon").hide();
                             $("#camera").show();
                             document.getElementById("joinBtn").disabled=false;
                      }
                      

                    })


                   
                    });
                });
          
        
        
        
        </script>

           
        



</body>
</html>