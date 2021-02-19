package com.database;

import java.io.InputStream;


public class UserBean implements Cloneable {
	
//Parameters
private String fname=null;
private String lname=null;
private String email=null;
private String username=null;
private String password=null;
private String dateOfBith=null;
private String gender=null;
private String company=null;
private String contact=null;
private InputStream profilePicture=null;
private InputStream coverPicture=null;

//Constructor
public UserBean() {
	
}
public void print() {
	System.out.println(fname);
	System.out.println(lname);
	System.out.println(email);
	System.out.println(username);
	System.out.println(password);
	System.out.println(dateOfBith);
	System.out.println(gender);
	System.out.println(company);
	System.out.println(contact);
	
}
public UserBean(String fname, String lname, String email,String username,  String password, String dateOfBith,
		String gender, String company, String contact,InputStream profilePicture,InputStream coverPicture) {
	this.fname = fname;
	this.lname = lname;
	this.email = email;
	this.username = fname+" "+lname;
	this.password = password;
	this.dateOfBith = dateOfBith;
	this.gender = gender;
	this.company = company;
	this.contact = contact;
	this.profilePicture=profilePicture;
	this.coverPicture=coverPicture;
}







public InputStream getProfilePicture() {
	return profilePicture;
}







public void setProfilePicture(InputStream profilePicture) {
	this.profilePicture = profilePicture;
}







public InputStream getCoverPicture() {
	return coverPicture;
}







public void setCoverPicture(InputStream coverPicture) {
	this.coverPicture = coverPicture;
}







// Getters and Setters
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getFname() {
	return fname;
}
public void setFname(String fname) {
	this.fname = fname;
}
public String getLname() {
	return lname;
}
public void setLname(String lname) {
	this.lname = lname;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getDateOfBith() {
	return dateOfBith;
}
public void setDateOfBith(String dateOfBith) {
	this.dateOfBith = dateOfBith;
}
public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}
public String getCompany() {
	return company;
}
public void setCompany(String company) {
	this.company = company;
}
public String getContact() {
	return contact;
}
public void setContact(String contact) {
	this.contact = contact;
}
}
