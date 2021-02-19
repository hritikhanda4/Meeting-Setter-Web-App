<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page isErrorPage="true" %>
        <%
    
    session.removeAttribute("user");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error</title>
</head>

    <style>
      body {
        text-align: center;
        padding: 40px 0;
        background: rgb(248, 246, 244);
      }
        h1 {
          color: #ff3333;
          font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
          font-weight: 900;
          font-size: 40px;
          margin-bottom: 10px;
        }
        p {
          color: #85929E ;
          font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
          font-size:21px;
          margin: 0;
        }
      i {
        color: #9ABC66;
        font-size: 100px;
        line-height: 200px;
        margin-left:-15px;
      }
      .card {
        background: white;
        padding: 60px;
        width: 300px;
        height: 400px;
        border-radius: 4px;
        box-shadow: 0 2px 3px rgb(230, 45, 45);
        
        
        display: inline-block;
        margin: 0 auto;
      }
      
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    </style>
     <style>

        #loginBtn{
        background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
        height: 50px;
        width: 215px;
        position: relative;
        left: 0px;
        border-radius: 10px; 
        top: 10px;
        color:white;
        font-size: 20px;
        margin:20px;
        outline: none;
        }
        </style>
        </head>
       
    <body >
      <div class="card">
        <div class="img">
          <img src="img/500.jpg" style="width:150px;height:160px;">
        </div>
        <h1>Error: 500</h1> 
        <br><br>
        <p>Oopss! Something went wrong!<br>
        <hr>
        INTERNAL SERVER ERROR</p>
         <form action="login">
            <input type="submit" value="Go To Login Page" id=loginBtn>
            </form>
        
      </div>
     

      

    </body>
</html>