<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% 
    ScheduleBean sb=(ScheduleBean) session.getAttribute("userSchedule");
    int sliderStart=0,sliderEnd=1449;
    %>
<!DOCTYPE html>
<html lang="en" style="font-size: 10px;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meeting Setter Web App</title>
    
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
    <script>
    var numFree=1;
    </script>
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


  #searchField{
  top:3vh;
  }
  
 
    </style>
    

    
</head>
<body>
<style>
  #searchField{
  top:3vh;
  }
  
  </style>
  
  <%@include file="index.jsp" %>
  
<script>
    function resetAll(){
    	$("#successLbl").hide();
    	$("#newEntryLbl").hide();
    	$("#oldEntryLbl").hide();
    	console.log("hello");
    	
    	window.location.href="resetSchedule";
    }
    </script>

  <div class="availability" style="border:0px;width: 81.74vw;height:91vh;position: relative;left: 18.25vw;top:8.8vh;background: rgba(0,0,0,0.7) url(img/back.png);background-blend-mode: darken;background-size: cover;opacity: 0.89;">
    
    
    <div class="dateDiv" style="background-color:white;height:fit-content;box-shadow:1px 1px 6px 1px;width:40vw;position: relative;left: 3.5%;top:5%;border-radius: 10px;" class=loginDiv>
      <form action="myScheduleDate">
        <label style="font-size: 3.5vh;color: rgb(37, 36, 36);font-weight: 700;position:relative;left: 6%;top:1vh;">Select Date </label>
     <br> 
      <input style="border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 35%;height:7vh;padding-left: 5%;margin-left: 5%;margin-top: 2%;" type="Date" name="date" id="date" required>
      <button class="Button" type="submit">Fetch Schedule</button>
      <button type="button" class="Button" onclick="javascript:resetAll()" style="width: 8vw;padding-left: 15px;padding-right:15px;margin-left: 14px;" >Reset</button>
      </form>
      <label id="oldEntryLbl" hidden="true" style="font-size: 3.5vh;color:rgb(9, 182, 9);position:relative;left: 33%;top:0vh;">Old entry Exist</label>
      <label id="newEntryLbl" hidden="true" style="font-size: 3.5vh;color:red;position:relative;left: 13%;top:0vh;">No old entry exist, Select new Schedule</label>
     <label id="successLbl" hidden="true" style="font-size: 3.5vh;color:rgb(9, 182, 9);position:relative;left: 43%;top:0vh;">Success</label>
    
    </div>
    
    
    <%
    if(sb!=null){
	
    if(sb.getDate()!=null){
    %>
    <script>
   	<% if(ScheduleBean.old){%>
	$("#oldEntryLbl").show();
	<%}else{%>
	$("#newEntryLbl").show();
	<%}%>
    $("#date").prop("readonly",true);
    $("#date").val(<%="\""+sb.getDate()+"\""%>);
    </script>
    <%	
    }
    
    }
if(sb!=null){
%>
<script>
function validate(){
	if(document.forms["hourForm"]["startTime"].value>=document.forms["hourForm"]["endTime"].value){
		alert("Select valid timings");
		return false;
	
		
	}
}
</script>
      <div class="hours" style="background-color:white;height:fit-content;box-shadow:1px 1px 6px 1px;width:25%;position: relative;left: 20.5%;top:10%;border-radius: 10px;" >
            <form action="timeLock" name="hourForm" onsubmit=" return validate()">
            <label style="font-size: 3.5vh;color: rgb(37, 36, 36);font-weight: 700;position:relative;left: 18%;top:1vh;">Available Hours</label> 
           
             <input style="border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 80%;height:6vh;padding-left: 20px;position: relative;left: 4%;margin-top: 4%;margin-bottom: 3%;" type="time" name="startTime" id="startTime" required  >
           	
             <label style="font-size: 2.8vh;color: rgb(37, 36, 36);font-weight: 700;position:relative;top: 5vh;right:42%;">TO</label>
             <br>
           
                <input style="border: 1px rgb(190, 190, 190) solid;border-radius: 10px;width: 80%;height:6vh;padding-left: 20px;position: relative;left: 4%;margin-top: 4%;" type="time" name="endTime" id="endTime" required >
           	 <button class="Button" type="submit" style="position:relative;left:25%;margin-bottom:10px;">Lock Hours</button>
    		<br>
             </form> 
           <label hidden="true" style="font-size: 3.5vh;color:red;position:relative;left: 15%;top:-1vh;">Select valid Timings</label>
      
      </div>

<%

if(sb.getAvailableHours()!=null){
	
	String time=sb.getAvailableHours();
	String timeArr[]=time.split("-");
	String startTime=timeArr[0];
	String endTime=timeArr[1];
	System.out.println(startTime);
	System.out.println(endTime);
	sliderStart=(Integer.parseInt(startTime.substring(0,2))*60)+Integer.parseInt(startTime.substring(3));
	sliderEnd=(Integer.parseInt(endTime.substring(0,2))*60)+Integer.parseInt(endTime.substring(3));
	
	%>
	<script>

    $("#startTime").val(<%="\""+startTime+"\""%>);
     $("#endTime").val(<%="\""+endTime+"\""%>);
     
    </script>
	<%
	
}

%>
<%
if(sb.getAvailableHours()!=null||sb.getFreeSlots()!=null||sb.getOccupiedSlots()!=null){
%>
      
    <div  class="TimeSlider" style="background-color:white;height:fit-content;box-shadow:1px 1px 6px 1px;width:50%;position: relative;left: 3.4%;top:15%;border-radius: 10px;padding-top: 10px;padding-bottom: -1px;" >      <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
      <label  style="font-size: 3vh;font-weight:700;color:black;position: relative;left: 15%;top:-1vh;">Select Your Free slots and add into list</label>

      <script src="jq/jquery-3.5.1.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <style >
    #slider-range,#SlideMax{width:90%;height: 20px;position: relative;left: 4%;}
    #slider-range,#time, #SlideMax, table{margin:10px;display:block;}
    .ui-slider .ui-slider-handle{
      height: 2.2em;
    }
    .ui-slider-horizontal .ui-slider-range {
    background-color:rgb(70, 99, 224);
}
</style>
  
    <div id="slider-range" ></div>
    <span id="SlideMax"></span>
    <br />
    <input id="my" type="text" value="" style="position: relative;top: -65px;left: 35%; width: 27%;padding-left: 20px;" readonly/>
    <input type="submit" name="scheduleSubmit" value="Add to Free Slots" id="scheduleSubmit" class="Button" style="position: relative;left:5%;top:-2vh;padding:10px;width: fit-content;" readonly/>
    
    </div>
    <script>
    var startTime;
    var endTime;
    $("#slider-range").slider({
        range: true, min:<%= sliderStart %>, max:<%=sliderEnd%>, values: [<%= sliderStart %>,<%=sliderEnd%>], step:5, slide: slideTime, change: checkMax
    });
    
    function slideTime(event, ui){
        var val0 = $("#slider-range").slider("values", 0),
            val1 = $("#slider-range").slider("values", 1),
            minutes0 = parseInt(val0 % 60, 10),
            hours0 = parseInt(val0 / 60 % 24, 10),
            minutes1 = parseInt(val1 % 60, 10),
            hours1 = parseInt(val1 / 60 % 24, 10);
        startTime = getTime(hours0, minutes0);
        endTime = getTime(hours1, minutes1);
     
        $("#my").val(startTime + ' - ' + endTime);
        checkMax();
    }
    function getTime(hours, minutes) {
        var time = null;
        minutes = minutes + "";
        hours = hours + "";
      
        if (hours.length == 1) {hours = "0" + hours;}
        if (minutes.length == 1) {minutes = "0" + minutes;}
        return hours + ":" + minutes;
    }
    function checkMax() {
        var size = $("#slider-range").slider("values", 1) - $("#slider-range").slider("values", 0);
        if( size >= 1449||size<15) {
        	
            $("#slider-range div")
                .addClass("ui-state-error")
                .removeClass("ui-widget-header");
                $("#scheduleSubmit")
                .addClass("disabled");
                document.getElementById("scheduleSubmit").disabled=true;
            $("#my").val("Select valid Slot>15min");
        }
        else {
            $("#slider-range div")
                .addClass("ui-widget-header")
                .removeClass("ui-state-error");
            $("#scheduleSubmit")
                .removeClass("disabled");
                document.getElementById("scheduleSubmit").disabled=false;
                $("#my").val(startTime + ' - ' + endTime);
        }
    }
    function deleteSlot(slotStart,slotEnd,rowId,itemId){
    	$("#"+rowId).css("text-decoration", "line-through");
    	$("#"+itemId).remove();
    	
    	for(var i=0;i<freeSlotsArr.length-1;i+=2){
    		if(freeSlotsArr[i]==slotStart&&freeSlotsArr[i+1]==slotEnd){
    			freeSlotsArr.splice(i,1);
    			freeSlotsArr.splice(i,1);
    			break;
    		}
    	}
    	for(var i=0;i<freeSlotsArr.length;i++){
    		console.log(freeSlotsArr[i]);
    		
    	}
    	console.log("---------");
    }
    $("#scheduleSubmit").on('click', function(){
      $("#my").val("Saving Wait!!");
        console.log(startTime);
        console.log(endTime);
        checkMax();
        
        for(var i=0;i<freeSlotsArr.length-1;i+=2){
        	
        	if((startTime<endTime)&&(freeSlotsArr[i]>=endTime)||(startTime>=freeSlotsArr[i+1]))
        		{
        		
        		}
        	else
        		{
        		alert("Slot Already Used");
        		return false;
        		}
        }
 		for(var i=0;i<occupiedSlotsArr.length-1;i+=2){
        	
        	if((startTime<endTime)&&(occupiedSlotsArr[i]>=endTime)||(startTime>=occupiedSlotsArr[i+1]))
        		{
        		
        		}
        	else
        		{
        		alert("Slot Already Occupied for Meetings");
        		return false;
        		}
        }
        freeSlotsArr.push(startTime);
        freeSlotsArr.push(endTime);
        $('#freeRecords').append('<tr id=row'+numFree+'>' +
          '<td >' + numFree++ + '</td>' +
            '<td style="width: 150px;position: relative;left: 30px;">' + startTime + '</td>' +
            '<td style="width: 150px;position: relative;left: 10px;">' + endTime + '</td>' +
            "<td id=\"item"+(numFree-1)+"\" style=\"width: 150px;position: relative;left: 10px;\"><a href=\"#\" onclick=\"javascript:deleteSlot('"+startTime+"','"+endTime+"','row"+(numFree-1)+"','item"+(numFree-1)+"')\"><img style=\"border-radius:25px;max-width:50%\" src=\"img/bin.jpg\"></img></a></td>"+               
            '</tr>');

       
        
            
    });
    slideTime();
    </script>
     
      
  <div class="freeSlots" style="background-color:white;height:70%;box-shadow:1px 1px 6px 1px;width:23%;position: absolute;top:5%;right:22%;border-radius: 10px;">
    <label  style="font-size: 3.5vh;font-weight:700;color:black;position:relative;left: 25%;top:1vh;">Free Slots</label>
    <hr style="margin-top: 1.5vh;width: 90%;left: 5%;position: relative;">
    <table id="freeRecords" style="font-size:2em;overflow:scroll;overflow-x: hidden;height:87%;">
      <tr>
      <th  style="width: 10%;">#</th>
      <th style="width: 40%;position: relative;left: 30px;">From</th>
      <th style="width: 40%;position: relative;left: 20px;">To</th>
      <th style="width: 20%;position: relative;left: 0px;">Delete</th>
        </tr>
    
    </table>




  </div>
 
  <style>
  table{margin:10px;display:block;}
  </style>
  
  
  <div class="occupiedSlots" style="background-color:white;height:70%;box-shadow:1px 1px 6px 1px;width:18%;position: absolute;top:5%;right:2%;border-radius: 10px;">
    <label  style="font-size: 3.5vh;font-weight:700;color:black;position:relative;left: 13%;top:1vh;">Occupied Slots</label>
    <hr style="margin-top: 1.5vh;width: 90%;left: 5%;position: relative;">
    <table id="occupiedRecords" style="font-size:2em;overflow:scroll;overflow-x: hidden;height:87%;">
      <tr>
      <th  style="width: 20px;">#</th>
      <th style="width: 150px;position: relative;left: 30px;">From</th>
      <th style="width: 150px;position: relative;left: 20px;">To</th>
        </tr>
    
    </table>


  </div>

  <button id="updateAllBtn" onclick="javascript:updateAll()" class="Button" style="position: absolute;left: 70%;height: fit-content;padding:20px;width: fit-content;top:82%"  >Update All Details</button>
  <%
}
}
  %>
  </div>
    









           <script>
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
        	 
            for(var i=0;i<freeSlotsArr.length-1;i+=2){
              $('#freeRecords').append('<tr id=row'+numFree+'>' +
          '<td >' + numFree++ + '</td>' +
            '<td style="width: 150px;position: relative;left: 30px;">' + freeSlotsArr[i] + '</td>' +
            '<td style="width: 150px;position: relative;left: 10px;">' + freeSlotsArr[i+1] + '</td>' +
            "<td id=\"item"+(numFree-1)+"\" style=\"width: 150px;position: relative;left: 10px;\"><a href=\"#\" onclick=\"javascript:deleteSlot('"+freeSlotsArr[i]+"','"+freeSlotsArr[i+1]+"','row"+(numFree-1)+"','item"+(numFree-1)+"')\"><img style=\"border-radius:25px;max-width:50%\" src=\"img/bin.jpg\"></img></a></td>"+               
            
            '</tr>');
            }
            
            var f="array="+freeSlotsArr;
            console.log(f);
          

        });</script>
        <script>
           var occupiedSlotsArr=[];
           <%
           if(sb!=null&&sb.getOccupiedSlots()!=null){
        	   for(String slot:sb.getOccupiedSlots().split(","))
        		   {
        		   %>
        		   occupiedSlotsArr.push(<%="\""+slot+"\""%>);
        		   <%
        		   }
           }
           %>
             
          $(function(){
        	  var numOccupied=1;
            for(var i=0;i<occupiedSlotsArr.length-1;i+=2){
              $('#occupiedRecords').append('<tr>' +
          '<td >' + numOccupied++ + '</td>' +
            '<td style="width: 150px;position: relative;left: 30px;">' + occupiedSlotsArr[i] + '</td>' +
            '<td style="width: 150px;position: relative;left: 10px;">' + occupiedSlotsArr[i+1] + '</td>' +
            '</tr>');
            }
            
            var f="array="+occupiedSlotsArr;
            console.log(f);
          $("#mainIndexImport").load("index.html"); 

        });</script>
        
        
     <script>
function updateAll(){
	$("#successLbl").hide();
	$("#newEntryLbl").hide();
	$("#oldEntryLbl").hide();
	$("#updateAllBtn").addClass("disabled");
	document.getElementById("updateAllBtn").disabled=true;
	
var f="email="+<%="\""+user.getEmail()+"\""%>+"&&freeSlotsArr="+freeSlotsArr+"&&occupiedSlotsArr="+occupiedSlotsArr+"&&date="+document.getElementById("date").value+"&&startTime="+document.getElementById("startTime").value+"&&endTime="+document.getElementById("endTime").value;
console.log(f);

$.ajax({
  url:"updateSchedule",
  data:f,
  type:'POST',
  success:function(data,textStatus,jqXHR){
      if(data.trim()=="Success")
      {
  		$("#successLbl").show();
  		$("#updateAllBtn").removeClass("disabled");
  		document.getElementById("updateAllBtn").disabled=false;
    	  window.location="resetSchedule";
      }
      else
      {
        window.location="500error";
        $("#updateAllBtn").removeClass("disabled");
      }

  },
  error:function(jqXHR,textStatus,errorThrown){  
        window.location="500error";
        $("#updateAllBtn").removeClass("disabled");
  }
  

})
}

$("#searchField").css("top","2.1vh");


</script>   



</body>
</html>