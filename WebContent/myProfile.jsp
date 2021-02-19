<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.database.*,java.io.*,java.sql.*" %>
    
    <%@include file="index.jsp" %>
    
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    
    <!-- Materlize CSS -->
    <link rel="stylesheet" href="css/materialize.min.css">
    <!-- My css -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/myProfile.css">
    
    <!-- Materialize JavaScript -->
   <script src="js/materialize.min.js"></script>

    <!-- Jquery for inbuilt functions -->
    <script src="jq/jquery-3.5.1.min.js" type="text/javascript"></script>
    
    <!-- For Icons  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
   
    
    <style>
    
.detailsLabel{
    display: block; width: 260px;
   /* // background-color: rgb(187, 175, 238); */
    /* border:1px black solid; */
    border-radius: 7px;
    color: black;
    
    padding: 10px;
    font-size: 18px;
    text-align: left;
    
}

#element{
 position: relative;
 left: 0px;
 padding-left: 25px;
 width:1235px;
 /* border:2px red solid; */
 top:10px;
}
#change{
    position: relative;
 top:6px;
 } 
 
.loader {
  border: 6px solid red;
  border-radius: 50%;
  border-top: 6px solid #3498db;
  width: 30px;
  height: 30px;
  -webkit-animation: spin 2s linear infinite; /* Safari */
  animation: spin 2s linear infinite;
}

/* Safari */
@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
 

 /* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
  background-color: #555;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 28px;
  width: 280px;
}

/* The popup form - hidden by default */
.form-popup {
  display: none;
  position: fixed;
  top: 350px;
  right: 400px;
  border: 3px solid #f1f1f1;
  
}

.form-popup1 {
  display: none;
  position: fixed;
  top: 350px;
  right: 90px;
  border: 3px solid #f1f1f1;
  
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
}

/* Full-width input fields */
.form-container input[type=file],{
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
}

/* When the inputs get focus, do something */
 .form-container input[type=file]:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
  background-color: #4CAF50;
  color: white;
 
  border: none;
  cursor: pointer;
  width: 100%;
    opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
  background-color: red;
}
.form-container .remove {

  background-color: blue;
   
}
/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}
 
 
</style>
   <script>
      
   $(document).ready(function()
	        {

                   $("#changeFirstName").click(function() {
            // $("#editFirstName").show();
            var x = document.getElementById("editFirstName");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
            $("#changeLastName").click(function() {
            // $("#editLastName").show();
            var x = document.getElementById("editLastName");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
            $("#changeEmail").click(function() {
            // $("#editEmail").show();
            var x = document.getElementById("editEmail");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
            $("#changeCompany").click(function() {
            // $("#editCompany").show();
            var x = document.getElementById("editCompany");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
            $("#changeContact").click(function() {
            // $("#editContact").show();
            var x = document.getElementById("editContact");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
            $("#changeDOB").click(function() {
            // $("#editContact").show();
            var x = document.getElementById("editDOB");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
   
            $("#changeGender").click(function() {
            // $("#editContact").show();
            var x = document.getElementById("editGender");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
            });
   
       
        
        
       
	        });
   

   function Update(id)
   {
   	
   	var val=null;
   
   	if(id=='gender')
   		val=document.forms["genderForm"]["gender"].value;
   	else        		
   	val=document.getElementById(id).value;
   	if(val==""){
        alert("Field can not be empty");
        $(".loaderMsg"+id).hide();
    return false;
    }
    else{
    	if(id=='contact')
    	   	var contactFormat=/^[0-9]{10}$/;

    	   	if(val.match(contactFormat)){
    	   	  
    	   	}
    	   	else
    	   	{
    	   	    alert("Enter valid Phone number");
    	   	    return false; 
    	   	}
    	   	 
		    updateParam(id,val);
		 $(".loaderMsg"+id).show();
		  }   
   	 
   	 	
   }
   
   
   
   
   function updateParam(column,val){
   	var f="column="+column+"&&email="+<%="\""+user.getEmail()+"\""%>+"&&value="+val;
   	
   	 $.ajax({
   		  url:"profileUpdate",
   		  data:f,
   		  type:'POST',
   		  success:function(data,textStatus,jqXHR){
   			 if(data.trim()=="Success"){
   				 console.log("LOg Hree");
   				 $(".loaderMsg"+column).hide();
   			  $("#myElem"+column).show();
                 setTimeout(function() { $("#myElem"+column).hide(); }, 5000);
                 location.reload();
   		  }
   	          else 
            {
             window.location="500error";
             $(".loaderMsg"+column).hide();
              }
      }
   })
   }
   
   
 
   
   function openForm() {
	   document.getElementById("myForm").style.display = "block";
	   
	 }

	 function closeForm() {
	   document.getElementById("myForm").style.display = "none";
	   
	 }
	 
	 function openForm1() {
		   document.getElementById("myForm1").style.display = "block";
		   
		 }

		 function closeForm1() {
		   document.getElementById("myForm1").style.display = "none";
		   
		 }
   
    </script>
   
</head>
<body>
	
	
    <div class="mainContent" id="mainContent">
       
        <div id="coverPhoto">
           
              <a href="<%=("resources/"+user.getEmail().trim()+"Cover.jpg")%>">
                   <img width=100% height=400px src=<%=("resources/"+user.getEmail().trim()+"Cover.jpg")%>>
               </a>
            
                <button  style="position: absolute;right:35px;top:370px;background:url(img/camera.png);width:28px;height:28px;border-radius:10px;border:none;cursor:pointer;float:left;" onclick="openForm()" title="Edit Cover"></button>
				
<div class="form-popup1" id="myForm">
 
   <form action="coverPhotoUpdate" onsubmit="ShowNow2()" method="post" class="form-container" enctype = "multipart/form-data">
   <h5><b>Choose Cover Picture</b></h5>
<input type="file" name="coverPic" accept="image/*" required>
<br> <br>
<div hidden class="loaderMsgcover" style="position:relative;left:45%;margin-bottom:3%">
        <div class="loader">
        </div>
          </div>
<button type="submit" class="btn remove" formnovalidate>Remove Pic</button>
<button type="submit" class="btn">Done</button>
    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
</form>
</div> 
       </div>
       
       <div id="dp" style="position: absolute; left: 510px; top:190px;">
           <a href="<%=("resources/"+user.getEmail().trim()+"Profile.jpg")%>">
          
           <img width="200" height= "200"  class="circle" src=<%=("resources/"+user.getEmail().trim()+"Profile.jpg")%>>
           </a>
      
              
          
          
          <button  style="position: absolute;left:135px;top:165px;background:url(img/camera.png);width:28px;height:28px;border-radius:10px;border:none;cursor:pointer;" onclick="openForm1()" title="Edit Profile Picture"></button>
<script>
function ShowNow()
{
	$('.loaderMsgprofile').show();
	}
function ShowNow2()
{
	$('.loaderMsgcover').show();
	}
	
</script>
<div class="form-popup" id="myForm1">
 
   <form action="profilePhotoUpdate" onsubmit="ShowNow()" method="post" class="form-container" enctype = "multipart/form-data">
   <h5><b>Choose Profile Picture</b></h5>
<input type="file" name="profilePic" accept="image/*" required>
<br> <br>
<div hidden class="loaderMsgprofile" style="position:relative;left:45%;margin-bottom:3%;">
        <div class="loader">
        </div>
          </div>
<button type="submit" class="btn remove" formnovalidate>Remove Pic</button>
<button type="submit" class="btn">Upload</button>
    <button type="button" class="btn cancel" onclick="closeForm1()">Close</button>
</form>
</div>
          
            
       </div>
       
       <div style="background-color:rgba(241, 239, 239, 0.897);padding: 20px;">
        <h5>General Account Settings</h5>
        <hr>
        <table>
            <tr >
               <td width=250px>
                    <label class="detailsLabel">First Name</label>
               </td>
                <td width=250px>
                    <label class="detailsLabel"><%=user.getFname() %></label></td>
                <td width=750px>
                    <div id="editFirstName" hidden="true">New First Name :
                        <input style="width: 190px;" type="text" name="Fname" id="Fname"/>
                        <button onclick="javascript:Update('Fname')" type=submit style="background: url(img/update.png);border-radius:25px;position:relative;left:10px;top:7px;width: 100px;border:0px;height: 30px;outline: none;"  >
                        </button>
         <div hidden class="loaderMsgFname" >
        <div class="loader">
        </div>
          </div>
       
       

                        <p id="myElemFname" style="display:none">Saved</p>
                    </div>  
                </td>
                <td>
                    <span title="Edit"><button id="changeFirstName" class="circle" value=click style="border:0px;background: url(img/change.png);width:30px; height:30px;">
                    </button></span>
                </td>
            </tr>
            
              
            <tr>
                <td>
                    <label class="detailsLabel">Last Name</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=user.getLname() %></label>
                </td>
                <td>
                    <div id="editLastName" hidden="true" >New Last Name :
                        <input style="width: 192px;" type="text"name="Lname" id="Lname" />
                        <button onclick="javascript:Update('Lname')" type=submit style="background: url(img/update.png);border-radius:25px;position:relative;left:10px;top:7px;width: 100px;border:0px;height: 30px;outline: none;"  >
                        </button>
                         <div hidden class="loaderMsgLname" >
        <div class="loader">
        </div>
          </div>
                         <p id="myElemLname" style="display:none">Saved</p>
                    </div>  
                </td>
                <td>
                    <span title="Edit"><button id="changeLastName" class="circle" value=click style="border:0px;background: url(img/change.png);width:30px; height:30px;">
                    </button></span>
                </td>
            </tr>

             <tr>
                 <td>
                     <label class="detailsLabel">Email</label>
                </td>
                <td>
                
                    <label class="detailsLabel"><%=user.getEmail()%></label>
                </td>
                <td>
                   
                </td>
               
            </tr>
            <tr>
                <td>
                    <label class="detailsLabel">Date of Birth</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=user.getDateOfBith() %></label>
                </td>
                <td>
                    <div id="editDOB" hidden="true" >Change Date of Birth :
                        <input  style="width: 160px;" type="date"name="dateofbirth" id="dateofbirth" />
                        <button onclick="javascript:Update('dateofbirth')"  type=submit style="background: url(img/update.png);border-radius:25px;position:relative;left:10px;top:7px;width: 100px;border:0px;height: 30px;outline: none;"  >
                        </button>
                         <div hidden class="loaderMsgdateofbirth" >
        <div class="loader">
        </div>
          </div>
                         <p id="myElemdateofbirth" style="display:none">Saved</p>
                    </div>  
                </td>
                <td>
                    <span title="Edit"><button id="changeDOB" class="circle" value=click style="border:0px;background: url(img/change.png);width:30px; height:30px;">
                    </button></span></td> 
            </tr>
            <tr>
                <td>
                    <label class="detailsLabel">Gender</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=user.getGender() %></label>
                </td>
                <td>
                    <div id="editGender" hidden="true" >Change Gender :
                    <form name="genderForm" action="" method="get">
                        <input style="width: 40px;" type="radio" name="gender" value="Male"   checked/><label style="color: black;font-size:20px;">Male</label>
                        <input style="width: 45px;" type="radio" name="gender" value="Female" checked/><label style="color: black;font-size:20px;">Female</label>
                        <button type="button" onclick="javascript:Update('gender')" style="background: url(img/update.png);border-radius:25px;position:relative;left:10px;top:7px;width: 100px;border:0px;height: 30px;outline: none;"  >
                        </button>
                        
                        </form>
                         <div hidden class="loaderMsggender" >
        <div class="loader">
        </div>
          </div>
                         <p id="myElemgender" style="display:none">Saved</p>
                    </div>  
                </td>
                <td>
                    <span title="Edit"><button id="changeGender" class="circle" value=click style="border:0px;background: url(img/change.png);width:30px; height:30px;">
                    </button></span></td> 
            </tr>

             <tr>
                <td>
                    <label class="detailsLabel">Company</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=user.getCompany() %></label>
                </td>
                <td>
                    <div id="editCompany" hidden="true">New Company Name :
                        <input style="width: 328px;" type="text"name="company" id="company" />
                        <button onclick="javascript:Update('company')"  type=submit style="background: url(img/update.png);border-radius:25px;position:relative;left:10px;top:7px;width: 100px;border:0px;height: 30px;outline: none;"  >
                        </button>
                         <div hidden class="loaderMsgcompany" >
        <div class="loader">
        </div>
          </div>
                         <p id="myElemcompany" style="display:none">Saved</p>
                    </div>  
                </td>
                <td>
                    <span title="Edit"><button id="changeCompany" class="circle" value=click style="border:0px;background: url(img/change.png);width:30px; height:30px;">
                    </button></span>
                </td> 
            </tr>

             <tr>   
                <td>
                     <label class="detailsLabel">Contact</label>
                </td>
                <td>
                    <label class="detailsLabel"><%=user.getContact() %></label>
                </td>
                <td>
                    <div id="editContact" hidden="true">New Contact :
                        <input style="width: 195px;" type="text" name="contact" id="contact" />
                        <button onclick="javascript:Update('contact')"  type=submit style="background: url(img/update.png);border-radius:25px;position:relative;left:10px;top:7px;width: 100px;border:0px;height: 30px;outline: none;"  >
                        </button>
                         <div hidden class="loaderMsgcontact" >
        <div class="loader">
        </div>
          </div>
                         <p id="myElemcontact" style="display:none">Saved</p>
                    </div>  
                </td>
                <td>
                    <span title="Edit"><button id="changeContact" class="circle" value=click style="border:0px;background: url(img/change.png);width:30px; height:30px;">
                    </button></span></td> 
            </tr>
       
            
        </table>
       </div>
       </div>
       
       






    
          
       

</body>
</html>