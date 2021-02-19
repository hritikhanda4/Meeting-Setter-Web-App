<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meeting Setter Web App</title>
    
    <!-- Materlize CSS -->
    <!-- <link rel="stylesheet" href="css/materialize.min.css"> -->
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    
    <!-- Materialize JavaScript -->
   <script src="js/materialize.min.js"></script>

    <!-- Jquery for inbuilt functions -->
    <script src="jq/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="js/validate.js"></script>
    
    <!-- For Icons  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>

i {
  font-size: 40px;
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
.btn{
        background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
        height: 43px;
        top:-4px;
        width: 100px;
        position: relative;
        left: 100px;
        border-radius: 10px; 
       
        color:white;
        font-size: 16px;
        outline: none;
    }
    </style>
    <script>
    $(document).ready(function() {
    	  $("#alreadyRegistered").hide();
          $("#submitBtn").show();
          $("#resetBtn").show();
          $("#processingIcon").hide();
          document.getElementById("submitBtn").disabled=false;
          document.getElementById("resetBtn").disabled=false;

        $("#loginBtn").click(function(){ 
        	 	
        		window.location="login";
        		$("#processingIcon").hide(); 
        	
        });
        $('.js-spin').addClass('icn-spinner') //remove class to stop animation
        
        
   $("#registerForm").on('submit',function(event){
    event.preventDefault();        
var fnameFormat=/^[a-zA-Z]+$/;
if(document.forms["registerForm"]["fname"].value.trim()==""){
    alert("First name can not be empty");
return false;
}
else if(document.forms["registerForm"]["fname"].value.trim().match(fnameFormat)){
   
}
else
{
    alert("First name should only contain alphabet");
return false;
}



var lnameFormat=/^[a-zA-Z]+$/;
if(document.forms["registerForm"]["lname"].value.trim()==""){
    alert("Last name can not be empty");
return false;
}
else if(document.forms["registerForm"]["lname"].value.trim().match(lnameFormat)){
   
}
else
{
    alert("Last name should only contain alphabet");
    return false;
}

if((document.forms["registerForm"]["lname"].value.trim().length+document.forms["registerForm"]["fname"].value.trim().length)<=18){
    
}
else {
    alert("First and Last name togeather should be less than or equal to 18 characters");
    return false;
}



    
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/;
if(document.forms["registerForm"]["email"].value.trim()==""){
    alert("Email can not be empty");
return false;
}
else if(document.forms["registerForm"]["email"].value.trim().match(mailformat))
{

}
else
{
alert("You have entered an invalid email address!");
return false;
}




if(document.forms["registerForm"]["password"].value.trim()==""){
    alert("Password can not be empty");
return false;
}
else if(document.forms["registerForm"]["password"].value.trim().length<6){
    alert("Password can not be less than 6 characters");
return false;
   
}
else
{
    if(document.forms["registerForm"]["confirmPassword"].value.trim()==document.forms["registerForm"]["password"].value.trim()){
        
    }
    else
    {
    alert("Both passwords does not match");
    return false;
    }
}


if(document.forms["registerForm"]["company"].value.trim()==""){
    alert("Company name can not be empty");
return false;
}
else
{
   
}

var contactFormat=/^[0-9]{10}$/;

if(document.forms["registerForm"]["contact"].value.trim().match(contactFormat)){
  
}
else
{
    alert("Enter valid Phone number");
    return false; 
}
//--------------------------------------------------------------

              $("#processingIcon").show();
              document.getElementById("submitBtn").disabled=true;
              document.getElementById("resetBtn").disabled=true;
              
              // serialize -----------FormData
              //  textutual-----------textual+binary images clobs blobs
              let f=new FormData(this);


              $.ajax({
                url:"registerServlet",
                data:f,
                type:'POST',
                
                success:function(data,textStatus,jqXHR){
                	//---------
                  if(data.trim()=="RegisteredSuccess"){
                	  $("#alreadyRegistered").hide();
                      $("#submitBtn").show();
                      $("#resetBtn").show();
                      $("#processingIcon").hide();
                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;

                	  
                    window.location="Success";
                  }
                  else if(data.trim()=="SendOtpFirst"){
                	  $("#alreadyRegistered").hide();
                      $("#submitBtn").show();
                      $("#resetBtn").show();
                      $("#processingIcon").hide();
                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;

                	  
                    alert("Send OTP first");
                  }
                  else if(data.trim()=="wrongOtp"){
                	  $("#alreadyRegistered").hide();
                      $("#submitBtn").show();
                      $("#resetBtn").show();
                      $("#processingIcon").hide();
                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;

                	  
                    alert("Wrong OTP Entered");
                  }
                  else if(data.trim()=="AlreadyRegistered")
                  {
                    $("#submitBtn").hide();
                    $("#resetBtn").hide();
                    $("#processingIcon").hide();
                    $("#alreadyRegistered").show();
                  }
                  else if(data.trim()==='500error')
                  {
                	  $("#alreadyRegistered").hide();
                      $("#submitBtn").show();
                      $("#resetBtn").show();
                      $("#processingIcon").hide();
                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;
                    window.location="500error";
                  }
                  else{
                	  $("#alreadyRegistered").hide();
                      $("#submitBtn").show();
                      $("#resetBtn").show();
                      $("#processingIcon").hide();
                      document.getElementById("submitBtn").disabled=false;
                      document.getElementById("resetBtn").disabled=false;
                    window.location="Error";
                  }

                },
                error:function(jqXHR,textStatus,errorThrown){
                	//---------
                  $("#alreadyRegistered").hide();
                  $("#submitBtn").show();
                  $("#resetBtn").show();
                  $("#processingIcon").hide();
                  document.getElementById("submitBtn").disabled=false;
                  document.getElementById("resetBtn").disabled=false;

                },
                processData:false,
                contentType:false                
                
              });

        });

      });
	function getOTP(){
		
	    
		var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/;
		if(document.getElementById("email").value.trim()==""){
		    alert("Email can not be empty");
		return false;
		}
		else if(document.getElementById("email").value.trim().match(mailformat))
		{

		}
		else
		{
		alert("You have entered an invalid email address!");
		return false;
		}


		
		$("#getOtpProcessing").show();
		$("#getOtpBtn").hide();
		var f="email="+document.getElementById("email").value.trim()+"&&newAccount=True";

		$.ajax({
		  url:"mailServlet",
		  data:f,
		  type:'POST',
		  success:function(data,textStatus,jqXHR){
		      if(data.trim()=="")
		      {
		    	  $("#getOtpProcessing").hide();
		  		
		  		$("#getOtpBtn").prop('value', 'Resend');
		  		$("#getOtpBtn").show();
		    	  alert("OTP send Success");
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
      </script>
</head>
<body>
  <div class="wrapper" style="width:100vw;height:145vh;display: flex;">
    <div class="leftContainer" style="width: 50%;height: 100%;">
      <img style="position: absolute; width:300px;top:120px;left: 220px;" src="img/joinUs.jpg">
     
      <button onclick="location.href='https://www.linkedin.com/in/hritik-handa-0649ba1a8/'"; style="position: relative;left: 38%;top:42%;color:white;" id="joinUsBtn">Join Us</button>
  
    </div>
    <div class="rightContainer" style="width:50%;height:100%;background-color: rgb(228, 226, 226);margin: 0px;padding: 0px;">
      <div class="cred"  style="font-size:25px;background-color:white;height:133vh;box-shadow:1px 1px 6px 1px;width:36vw;position: relative;left: 13%;border-radius: 10px;" class=loginDiv>
                
                
                <form name="registerForm" action="" method="post" id="registerForm">
                    <h5 style="text-align: center;position: relative;top: 20px;font-size:24px;">Registration Form</h5>
                    <hr>
                   <label class="label1" > First Name :</label> <input id="fname" type="text" name="fname" required>
                   <hr>
                   <label class="label1">Last Name :</label> <input id="lname" type="text" name="lname" required>
                    <hr>
                    <label class="label1">Email :</label> <input style="width:240px;left:96px;" id="email"  type="text" name="email"  required>
                     <button class="btn" onclick="getOTP()" type="button" id="getOtpBtn" >Get OTP</button> 
                    <div id="getOtpProcessing" hidden="true" style="height:1px;position:relative;left:73%;top:-7vh">
                     <i id="processingIcon2"  style="font-size: 6vh;position: relative;left: 10%;top:1vh" class="material-icons js-spin">rotate_right</i>
                    </div>
                    <hr>
                    <label class="label1">OTP :</label> <input style="position:relative;width:300px;left:100px;height:30px;font-size:20px;border-radius:10px;border:2px lightgrey solid;" id="otp" type="text" name="otp" required>
                    
                    <hr>                 
                    <label class="label1">Password :</label> <input style="width:368px;left:70px;" id="password" type="password" name="password" required>
                    <hr>
                    <label class="label1">Confirm Password :</label> <input style="width:307px;left:65px;" id="confirmPassword" type="password" name="confirmPassword" required>
                    <hr>
                    <label class="label1">Date of Birth :</label> <input id="DOB" style="width:178px;padding-left: 50px;" type="date" name="DOB" required>
                    <hr>
                    <label  class="label1">Gender :</label> 
                    
                    <input style="position: relative;left:60px;top: 2px;" type="radio" name="genderRadio" value="Male" required><label style="position: relative;left: 70px;top: 2px;font-size: 23px;">Male</label>
                    <input style="position: relative;left:90px;top: 2px;" type="radio" name="genderRadio" value="Female" ><label style="position: relative;left: 100px;top: 2px;font-size: 23px;">Female</label>
                    <hr>
                    <label class="label1">Company :</label> <input style="width:360px;left:75px;" id="company" type="text" name="company" required>
                    <hr>
                    <label class="label1">Contact :</label> <input style="width:360px;left:90px;" id="contact" type="text" name="contact" required>
                    <hr>
                    <label class="label1">Profile Picture :</label> <input style="width:350px;position: relative;left: 70px;top:3px;font-size: 16px;" type="file" id="profilePicture" name="profilePicture" accept="image/*" required>
                    <hr>
                    <label class="label1">Cover Picture :</label> <input style="width:350px;position: relative;left: 70px;top:3px;font-size: 16px;" type="file" id="coverPicture" name="coverPicture" accept="image/*" >
                    <hr>
                    <div style="display: flex;">
                    <div style="width: 20px;height: 20px;">
                    <i id="processingIcon"  style="font-size: 6vh;position: relative;left: 100%;top:1vh" class="material-icons js-spin">rotate_right</i>
                    </div>
                    
                    <button type="submit" id="submitBtn" >Register</button>
                    <button style="position:relative;left:120px;" type="reset" id="resetBtn" >Reset</button>
                  </div>
                  </form>
                  <div id="alreadyRegistered" hidden="true">
                    <label style="font-size: 25px;color: rgb(235, 33, 33);position: relative;top: 10px;left: 7%;color:rgb(240, 34, 34);" id="logoutLabel" class="label">Already Registered..Please login</label>
                    <button style="left:50px;" value="click" id="loginBtn" >Login</button>
            </div>
    
        </div>

        <style>
            #joinUsBtn:hover,#submitBtn:hover,#resetBtn:hover,#loginBtn:hover
    {
         background:linear-gradient(90deg, rgb(20, 13, 156) 0%, rgb(5, 11, 77) 20%, rgb(78, 32, 116) 100%);
    }
    #submitBtn,#resetBtn,#joinUsBtn,#loginBtn{
        background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
        height: 50px;
        width: 150px;
        position: relative;
        left: 100px;
        border-radius: 20px; 
        top: 5px;
        color:white;
        font-size: 20px;
        outline: none;
    }
            .label1{
                /* border:2px red solid; */
                font-size: 18px;
                color: black;
                position: relative;
                left: 30px;
                top:5px;
                

            }
            #fname,#lname,#email,#DOB,#company,#contact,#password,#confirmPassword{
            position: relative;
            font-size:x-large;
            padding-left:10px;
            left:60px;
            border: 1px rgb(182, 180, 180) solid;
            border-radius: 10px;
            width: 65%;
            height:40px;
            
            margin-top: 0px;
            }
            </style>

</body>
</html>