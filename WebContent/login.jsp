<%@ page import="com.servlets.LogoutServlet,com.database.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    // If session is already logged in    
    
    UserBean user=(UserBean) session.getAttribute("userCurrent");
    if(user!=null)
    	response.sendRedirect("myProfile");

    %>


    
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="HandheldFriendly" content="true">
    <title>Login</title>
    
    <!-- Materlize CSS -->
    <link rel="stylesheet" href="css/materialize.min.css">
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


    #createNewAccountButton{    
    background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
    height:7vh;
    width: 22.5vw;
    position: relative;
    left: 20px;
    border-radius: 10px;
    top: 45px;
    color:white;
    font-size: 20px;
    outline: none;
    }
    #createNewAccountButton:hover,#loginBtn:hover
    {
         background:linear-gradient(90deg, rgb(20, 13, 156) 0%, rgb(5, 11, 77) 20%, rgb(78, 32, 116) 100%);
    }
    #loginBtn{
        background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
        height: 7vh;
        width: 22.5vw;
        position: relative;
        left: 20px;
        border-radius: 10px; 
        top: 30px;
        color:white;
        font-size: 20px;
        outline: none;
    }
      .label{
            font-size: 17px;
            color: rgb(235, 33, 33);
            position: relative;
            top: 50px;
            left: 23%;
        }
    
    
    </style>
    <style>
    .loader {
        position: relative;
        top:30px;
        
        left: 139px;
  border: 16px solid #f3f3f3; /* Light grey */
  border-top: 16px solid #3498db; /* Blue */
  border-radius: 100%;
  width: 100px;
  height: 100px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    </style>
</head>
<body>

<div class="wrapper" style="width:100vw;height:100vh;display: flex;">
    <div class="leftContainer" style="width: 50%;height: 100%;">
        <img src="img/loginLogo.JPG" style="position: relative;top: 27.6%;left:5.4%;max-width: 100%;">
    
      </div>
      <div class="rightContainer" style="width:50%;height:100%;background-color: rgb(228, 226, 226);margin: 0px;padding: 0px;">
        <div class="cred" style="background-color:white;box-shadow:1px 1px 6px 1px;width:50%;position: relative;left:25%;top: 28%;border-radius: 3%;height: fit-content;padding-bottom: 8%;" class=loginDiv>
            <form  name="loginForm" action="" id="loginForm">
           
                <i style="position: relative;left: 3.5%;top: 4vh;font-size: 40px;" class="material-icons">perm_identity</i><input required style="position: relative;top:2.6vh;left:5%;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 70%;height:6.5vh;padding-left: 20px;" type="text" name="email" id="email" placeholder="Email"><br>
                <i style="position: relative;left: 3.5%;top: 4vh;font-size: 40px;" class="material-icons">lock_outline</i><input required style="position: relative;top:2.6vh;left:5%;border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 70%;height:6.5vh;padding-left: 20px;" type="password" name="password" id="password" placeholder="Password">
            <button id="loginBtn" type="submit">Login</button>
            </form>
            <div class="loaderMsg" hidden >
            <div class="loader">
            </div>
            <br>
            <label style="font-size:3vh;color:black;position:relative;left:34%;top:3vh;">Please Wait...</label>
            </div>
            <a href="forgetPassword" style="position:relative;top: 5vh;left: 35%;">Forget Password</a>
            <hr style="position: relative;top: 40px;left: 0px;width: 370px;">
            <button value="onclick" id="createNewAccountButton" >Create New Account</button>
            <br>
             <%
             
            if(LogoutServlet.logout==true)
            {
            %>
            	 <label style="font-size: 17px;color: rgb(235, 33, 33);position: relative;top: 50px;left: 35%;color:green;" id="logoutLabel" class="label">Logout Success!</label>
            <%
            LogoutServlet.logout=false;
            }
            %> 
            <label id="newUser" hidden="true" style="position: relative;left: 70px;" class="label">User is not Registered! Register First</label>
            <label id="invalidData" hidden="true" class="label">Invalid Credentials ! Try Again</label>
        </div>

    </div>
    
    <script type="text/javascript">
        document. getElementById("createNewAccountButton"). onclick = function () {
        location.href = "register";
        };
        $(document).ready(function(){
            $("#loginForm").on('submit',function(event){
            	event.preventDefault();
            	
                var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/;
                if(document.forms["loginForm"]["email"].value==""){
                    alert("Email can not be empty");
                return false;
                }
                else if(document.forms["loginForm"]["email"].value.match(mailformat))
                {
                
                }
                else
                {
                alert("You have entered an invalid email address!");
                return false;
                }
                
                
                
                
                if(document.forms["loginForm"]["password"].value==""){
                    alert("Password can not be empty");
                return false;
                }
                else if(document.forms["loginForm"]["password"].value.length<6||document.forms["loginForm"]["password"].value.length>20){
                    alert("Password can not be less than 6 or more than 20 characters");
                return false;
                   
                }
                else
                {
                    
               
                }
                // preventing form to go to servlet
                $("#loginForm").hide();
                $(".loaderMsg").show();
                $("#invalidData").hide()
               $("#newUser").hide()
				$("#logoutLabel").hide()
                

               

                var f=$(this).serialize();    // compressing all detailss email and pass
                
                // Sending only request
                $.ajax({
                	 

                    url:"loginServlet",
                    data:f,
                    type:'POST',
                    success:function(data,textStatus,jqXHR){
                    	console.log(data);
                        $("#loginForm").show();
                        $(".loaderMsg").hide();
                        
                        
                      
                        if(data.trim()==='Matched')
                        	{
                        	
                        	 window.location="myProfile"
                        	}
                        else if(data.trim()==='NotMatched')
                        	{
                        	  $("#invalidData").show()
                        	}
                        else if(data.trim()==='NotRegistered')
                    	{
                    	  $("#newUser").show()
                    	}
                        else if(data.trim()==='500Error')
                    	{
                        	 window.location="500error"
                    	}
                        else
                        {
                        	 window.location="Error"
                        }
                    },
                    error:function(jqXHR,textStatus,errorThrown){  
                        $("#loginForm").show();
                        $(".loaderMsg").hide();
                    }
                })

            });
            
        });

        </script>

</body>
</html>