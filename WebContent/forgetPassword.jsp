<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forget Password</title>
    
    <!-- Materlize CSS -->
    
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    
    <!-- Materialize JavaScript -->
   <script src="js/materialize.min.js"></script>

    <!-- Jquery for inbuilt functions -->
    <script src="jq/jquery-3.5.1.min.js" type="text/javascript"></script>
    
    <!-- For Icons  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <style>
    .btn{
        background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
        height: 40px;
        width: 100px;
        position: relative;
        left: 25px;
        border-radius: 10px; 
        top: 16px;
        color:white;
        font-size: 16px;
        outline: none;
    }
    .btn:hover{
         background:linear-gradient(90deg, rgb(20, 13, 156) 0%, rgb(5, 11, 77) 20%, rgb(78, 32, 116) 100%);
    }
    

    .loader {
        position: relative;
        top:51px;
        left: 190px;
  border: 10px solid #f3f3f3; /* Light grey */
  border-top: 10px solid #3498db; /* Blue */
  border-radius: 50%;
  width: 25px;
  height: 25px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    
.disable{
color:grey;
font-size:300px;
}

    .loader {
        position: relative;
        top:1.0rem;
        
        left: 9.5rem;
  border: 1.0rem solid #f3f3f3; /* Light grey */
  border-top: 1.0rem solid #3498db; /* Blue */
  border-radius: 100%;
  width: 8.0rem;
  height: 8.0rem;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    
</style>
</head>
<body>
<div class=container style="width: 100vw; height: 100vh;display: flex;margin: 0px;padding: 0px;"> 
   
  <div class="leftContainer" style="width: 50%;height: 100%;">
    <img src="img/loginLogo.JPG" style="position: relative;top: 27.6%;left:5.4%;max-width: 100%;">

  </div>
  <div class="rightContainer" style="width:50%;height:100%;background-color: rgb(228, 226, 226);margin: 0px;padding: 0px;">
      <div class="cred" style="background-color:white;height:fit-content;padding-bottom:4%;box-shadow:1px 1px 6px 1px;width:fit-content;position: relative;left: 25%;top: 20%;border-radius: 10px;" class=loginDiv>
       
        <input style="outline:none;border: 1px rgb(190, 190, 190) solid;border-radius: 15px;width: 55%;height:7vh;padding-left: 20px;margin-left:5%;margin-top: 5%;font-size: 1.1vw;" type="text" name="email" id="email" placeholder="Enter Email">
        <button onclick="javascript:sendMyMail()" class="btn" id="getOtpBtn" type="submit" style="font-size: 1.1vw;position: relative;top:0%;width: 6.5vw;height: 5.5vh;left: 4%;">Get OTP</button>
       	<br>
        <input style="border: 1px rgb(190, 190, 190) solid;outline:none;border-radius: 15px;width: 55%;height:7vh;padding-left: 20px;margin-left:5%;margin-top: 5%;font-size: 1.1vw;" name="otp" id="otp" placeholder="Enter OTP" >
        <button onclick="javascript:sendMyMail()" class="btn" id="resendOtpBtn" type="submit" style="font-size: 1.1vw;position: relative;top:0%;width: 6.5vw;height: 5.5vh;left: 4%;">Resend</button>
        <button  onclick="javascript:confirmOtp()" id="confirmBtn" style="position: relative;left: 37%;font-size: 1.3vw;width: 8vw;height: 5.5vh;top: 2.5vh;" class="btn" value=click >Confirm</button>
        <progress hidden="true" style="position: relative;width: 90%;left: 5%;bottom:-4vh;" value="0" max="30" id="progressBar" >32%</progress>
      	<p hidden="true" id="warning" style="color: red;font-size:3.5vh;position: relative;left: 25%;margin-top: 30px;margin-bottom: -10px;">Wrong OTP entered</p>
       	<p hidden="true" id="warning2" style="color: red;font-size:3.5vh;position: relative;left: 32%;margin-top: 30px;margin-bottom: -10px;">Send OTP First</p>
           
       </div>
    
      
    <div hidden id="changePass"  class="cred" style="background-color:white;height:fit-content;padding-bottom:4%;box-shadow:1px 1px 6px 1px;width:55%;position: relative;left: 27.5%;top: 25%;border-radius: 10px;" class=loginDiv>
      <div id="details">
      <input style="outline:none;border: 1px rgb(190, 190, 190) solid;border-radius: 15px;width: 85%;height:7vh;padding-left: 20px;margin-left:20px;margin-top: 20px;font-size: 1.1vw;" type="text" name="password" id="password" placeholder="Enter new Password" >
      <input style="outline:none;border: 1px rgb(190, 190, 190) solid;border-radius: 15px;width: 85%;height:7vh;padding-left: 20px;margin-left:20px;margin-top: 20px;font-size: 1.1vw;" type="text" name="confirmPassword" id="confirmPassword" placeholder="Confirm new Password">
      <button onclick="javascript:update()" id="updateBtn" style="position: relative;left: 37%;font-size: 1.3vw;width: 8vw;height: 5.5vh;top: 2.5vh;" class="btn" value=click >Update</button>
      </div>
      <div hidden class="loaderMsg" >
        <div class="loader">
        </div>
        <label style="font-size:2.0rem;color:black;position:relative;left:10rem;top:1.5rem;font-size: 1.5vw;">Please Wait...</label>
      </div>
    </div>        
	</div>
</div>


    <script>       
       
       
        $(document).ready(function()                     // Jquery
        {
        	 $("#resendOtpBtn").addClass("disable");
        	 document.getElementById("resendOtpBtn").disabled = true;    
            
        });

//  Send OTP --------------------------------------------------------------------------
        
        function sendMyMail(){
        	 $("#warning").hide();
        	 $("#warning2").hide();
        	 $("#newUser").hide()
          var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/;
          if(document.getElementById("email").value==""){
              alert("Email can not be empty");
          return false;
          }
          else if(document.getElementById("email").value.match(mailformat))
          {
				
          }
          else
          {
          alert("You have entered an invalid email address!");
          return false;
          }

        	var email=document.getElementById("email").value;
        	console.log(email);
        	sendMail(email);
        }






        
        function sendMail(str){
          	 $("#getOtpBtn").addClass("disable");
          	document.getElementById("getOtpBtn").disabled = true;
       	 $("#resendOtpBtn").addClass("disable");
       	document.getElementById("resendOtpBtn").disabled = true;	
             $("#progressBar").show();
             $("#confirmBtn").addClass("disable");
            	document.getElementById("confirmBtn").disabled = true;	     
            var timeleft = 30;
            var downloadTimer = setInterval(function(){
            if(timeleft <= 0){
              clearInterval(downloadTimer);
              document.getElementById("resendOtpBtn").disabled = false;
              $("#resendOtpBtn").removeClass("disable");
              $("#progressBar").hide();
            	
            }
            else if(timeleft==15){
            	$("#confirmBtn").removeClass("disable");
               	document.getElementById("confirmBtn").disabled = false;	
            }
            document.getElementById("progressBar").value = 30 - timeleft;   // Settting the value
            timeleft -= 1;
            }, 1000);  
         



          //-------------------Ajax reuqest----------------

          var f="email="+str;;

          $.ajax({
            url:"mailServlet",
            data:f,
            type:'POST',
            success:function(data,textStatus,jqXHR){
                if(data.trim()=="SendSuccess")
                {
                  
                }
                else if(data.trim()==='NotRegistered')
            	{
            	 
            	  alert("User is not registered!");
            	  window.location.reload(); 
            	
            	}
                else
                {
                 // window.location="500error";
                }

            },
            error:function(jqXHR,textStatus,errorThrown){  
                  // window.location="500error";
            }
            

          })
        }




// Confirm OTP -------------------------------------------------------------------------------------

        function confirmOtp(){
        	
            $("#warning").hide();
            $("#warning2").hide();

          var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/;
          if(document.getElementById("email").value==""){
              alert("Email can not be empty");
          return false;
          }
          else if(document.getElementById("email").value.match(mailformat))
          {

          }
          else
          {
          alert("You have entered an invalid email address!");
          return false;
          }

          if(document.getElementById("otp").value==""){
              alert("OTP can not be empty");
          return false;
          }
          else
          {

          }
        	var email=document.getElementById("email").value;
          var otp=document.getElementById("otp").value;
        	
        	confirm(email,otp);
        }


        function confirm(email,otp){
          $("#getOtpBtn").addClass("disable");
          	document.getElementById("getOtpBtn").disabled = true;
       	 $("#resendOtpBtn").addClass("disable");
       	document.getElementById("resendOtpBtn").disabled = true;	
             $("#warning").hide();
             $("#warning2").hide();
        	 
          
             var f="email="+email+"&&"+"otp="+otp;

$.ajax({
  url:"verifyOtpServlet",
  data:f,
  type:'POST',
  success:function(data,textStatus,jqXHR){
      if(data.trim()=="Success")
      {
           $("#changePass").show();
           $("#progressBar").hide();
           $("#resendOtpBtn").addClass("disable");
        	document.getElementById("resendOtpBtn").disabled = true;
           $("#confirmBtn").addClass("disable");
         	document.getElementById("confirmBtn").disabled = true;
           $("#email").prop("readonly", true);
           $("#otp").prop("readonly", true);
           $("#email").addClass("disable");
           $("#otp").addClass("disable");       
      }
      else if(data.trim()=="SendOTPfirst"){
    	  $("#progressBar").hide();
    	  $("#warning2").show();
    	  $("#getOtpBtn").removeClass("disable");
      	document.getElementById("getOtpBtn").disabled = false;
      }
      else if(data.trim()=="otpNotMatched"){
    	 $("#warning").show();
      }
      else 
      {
        window.location="500error";
      }

  },
  error:function(jqXHR,textStatus,errorThrown){  
        window.location="500error";
  }
  

})

}
function update(){
  var email=document.getElementById("email").value;
  var pass=document.getElementById("password").value;
  var confirm=document.getElementById("confirmPassword").value;
  
  if(pass.length<6){
    alert("Password length should be greater than 6")
return false;
  }
  else if(pass!=confirm){
  alert("Both password not matches")
return false;
  }else{
    updateDB(email,pass);
  }

}
function updateDB(email,pass){

$("#details").hide();
$(".loaderMsg").show();


  var f="email="+email+"&&"+"password="+pass;
  $.ajax({
  url:"updateServlet",
  data:f,
  type:'POST',
  success:function(data,textStatus,jqXHR){
      if(data.trim()=="Success")
      {
        window.location="Success"; 
        $("#details").show();
$(".loaderMsg").hide();
      }
      else 
      {
        window.location="500error";
        $("#details").show();
$(".loaderMsg").hide();
      }

  },
  error:function(jqXHR,textStatus,errorThrown){  
        window.location="500error";
        $("#details").show();
$(".loaderMsg").hide();
  }
  

})




}
  
            
    </script>


  
</body>
</html>