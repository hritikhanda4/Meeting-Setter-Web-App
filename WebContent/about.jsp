<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html >
<html lang="en" style="font-size:10px;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meeting Setter Web App</title>
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    
      <style>
          #loginBtn{    
    background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
    border: 2px white solid;

    border-radius: 1.0rem;
    color:white;
    font-size: 2.0vw;
    outline: none;
    }
    #loginBtn:hover
    {
         background:linear-gradient(90deg, rgb(20, 13, 156) 0%, rgb(5, 11, 77) 20%, rgb(78, 32, 116) 100%);
    }
        .bounce {
            height: 50%;
            overflow: hidden;
  
            width: 100%;
            background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
            color: white;
            border: 1px rgb(190, 190, 190) solid;
        }
        
        .bounce p {
            position: relative;
            width: 100%;           
            height: 100%;
            margin: 0rem;
            font-size: 2vw;
            line-height: 50px;
            text-align: center;
            -moz-transform: translateX(50%);
            -webkit-transform: translateX(50%);
            transform: translateX(50%);
            -moz-animation: bouncing-text 5s linear infinite;
            -webkit-animation: bouncing-text 5s linear infinite ;
            animation: bouncing-text 10s linear infinite;
        }
        
        @-moz-keyframes bouncing-text {
            0% {
                -moz-transform: translateX(50%);
            }
            100% {
                -moz-transform: translateX(-50%);
            }
        }
        
        @-webkit-keyframes bouncing-text {
            0% {
                -webkit-transform: translateX(50%);
            }
            100% {
                -webkit-transform: translateX(-50%);
            }
        }
        
        @keyframes bouncing-text {
            0% {
                -moz-transform: translateX(50%);
                -webkit-transform: translateX(50%);
                transform: translateX(50%);
            }
            100% {
                -moz-transform: translateX(-50%);
                -webkit-transform: translateX(-50%);
                transform: translateX(-50%);
            } 
        }
    </style>
   
</head>
<body style="margin: 0rem;padding: 0rem;" onload="redirect_Page(this)">
<div class=container style="width: 100vw;height:100vh;display: flex;margin: 0px;padding: 0px;">
    <div class="header bounce" style="display:flex;width:100vw;height: 8%;background-color: pink;align-items: center;"> <p> ABOUT US </p>
   <button style="width: 15%;height:80%;margin-top:0.1%;margin-right:0.5%;font-size: 1.4vw;" id="loginBtn"  onclick="window.location.href='login'">Go to Login Page</button>
 </div>
    <div class="leftContainer" style="width:50%;height:100%;background-color:rgb(247, 244, 244);">
        <img style="width:80%;position: relative;left: 8%;top: 2%;max-width: 100%;" src="img/loginLogo.JPG">
        <img src="img/vvv.png" style="position: relative;left: 8%;max-width: 85%;">
        
    </div>

    <div class="rightContainer" style="width:50%;height:100%;background-color: rgb(212, 211, 211);" >
        <label style="position: relative;top:15%;font-size: 3em;display:block;text-align: center;">Team Members</label>
        <ul style="position: relative;top: 20%;">
        <li style="margin:5%;display: flex;">
            <img src="img/me.jpg" style="max-width:30%;border-radius: 50%;">
            <p style="font-size: 1.4vw;margin: 8%;">
                Hritik Handa
                <br>
                Student- B.Tech-CSE
                <br>
                Chandigarh Group of colleges
            </p>
        </li>
        <li style="margin:5%;display: flex;">
            <img src="img/mee.jpg" style="max-width:30%;border-radius: 50%;">
            <p style="font-size: 1.4vw;margin: 8%;">
                Divyanshi Kaushik
                <br>
                Student- B.Tech-CSE
                <br>
                Chandigarh Group of colleges
            </p>
        </li>
    </ul>
    
    </div>
    
       </div>
       
 
    <script>
        // Using ES6 feature.
        let redirect_Page = (ele) => {
            ele.disabled = true;
            let tID = setTimeout(function () {
                window.location.href = "login";
                
                window.clearTimeout(tID);		
                
            }, 4000);
        }
    </script>
   
</body>
</html>