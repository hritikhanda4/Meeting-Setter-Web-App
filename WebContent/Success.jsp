<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    </head>
    <style>
      body {
        text-align: center;
        padding: 40px 0;
        background: rgb(248, 246, 244);
      }
        h1 {
          color: #88B04B;
          font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
          font-weight: 900;
          font-size: 40px;
          margin-bottom: 10px;
        }
        p {
          color: #404F5E;
          font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
          font-size:20px;
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
        box-shadow: 0 2px 3px #C8D0D8;
        
        
        display: inline-block;
        margin: 0 auto;
      }
      .loader {
        position: relative;
        top:15px;
        left: 101px;
  border: 16px solid #f3f3f3; /* Light grey */
  border-top: 16px solid #3498db; /* Blue */
  border-radius: 100%;
  width: 50px;
  height: 50px;
  animation: spin 2s linear infinite;
}



span {
  content: "\2713";
}





@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
    </style>
    <body onload="redirect_Page(this)">
      <div class="card">
      <div style="border-radius:200px; height:200px; width:200px; background: #F8FAF5; margin:0 auto;">
        <i class="checkmark"><span>&#10003;</span></i>
      </div>
        <h1>Success</h1> 
        <p>Operation Success<br/><hr> Redirecting you to login Page</p>
        <div class="loader"></div>
      </div>
     

      <script>
        // Using ES6 feature.
        let redirect_Page = (ele) => {
            ele.disabled = true;
            let tID = setTimeout(function () {
                window.location.href = "login";
                
                window.clearTimeout(tID);		
                
            }, 1500);
        }
    </script>

    </body>
</html>