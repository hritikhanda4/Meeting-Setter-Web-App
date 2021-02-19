
function ValidateRegister()
{


var fnameFormat=/^[a-zA-Z]+$/;
if(document.forms["form"]["fname"].value==""){
    alert("First name can not be empty");
return false;
}
else if(document.forms["form"]["fname"].value.match(fnameFormat)){
   
}
else
{
    alert("First name should only contain alphabet");
return false;
}



var lnameFormat=/^[a-zA-Z]+$/;
if(document.forms["form"]["lname"].value==""){
    alert("Last name can not be empty");
return false;
}
else if(document.forms["form"]["lname"].value.match(lnameFormat)){
   
}
else
{
    alert("Last name should only contain alphabet");
    return false;
}

if((document.forms["form"]["lname"].value.length+document.forms["form"]["fname"].value.length)<=18){
    
}
else {
    alert("First and Last name togeather should be less than or equal to 18 characters");
    return false;
}



    
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
if(document.forms["form"]["email"].value==""){
    alert("Email can not be empty");
return false;
}
else if(document.forms["form"]["email"].value.match(mailformat))
{

}
else
{
alert("You have entered an invalid email address!");
return false;
}




if(document.forms["form"]["password"].value==""){
    alert("Password can not be empty");
return false;
}
else if(document.forms["form"]["password"].value.length<6){
    alert("Password can not be less than 6 characters");
return false;
   
}
else
{
    if(document.forms["form"]["confirmPassword"].value==document.forms["form"]["password"].value){
        
    }
    else
    {
    alert("Both passwords does not match");
    return false;
    }
}


var companyFormat=/^[a-zA-Z]+$/;
if(document.forms["form"]["company"].value==""){
    alert("Company name can not be empty");
return false;
}
else if(document.forms["form"]["company"].value.match(companyFormat)){
   
}
else
{
    alert("Company Name should only contains alphabets");
    return false; 
}

var contactFormat=/^[0-9]{10}$/;

if(document.forms["form"]["contact"].value.match(contactFormat)){
   return true;
}
else
{
    alert("Enter valid Phone number");
    return false; 
}


}


