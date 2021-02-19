package com.database;

public class ScheduleBean {
private String email=null;
private String date=null;
private String availableHours=null;
private String freeSlots=null;
private String occupiedSlots=null;
public static boolean old=false;
public ScheduleBean() {
	
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getAvailableHours() {
	return availableHours;
}
public void setAvailableHours(String availableHours) {
	this.availableHours = availableHours;
}
public String getFreeSlots() {
	return freeSlots;
}
public void setFreeSlots(String freeSlots) {
	this.freeSlots = freeSlots;
}
public String getOccupiedSlots() {
	return occupiedSlots;
}
public void setOccupiedSlots(String occupiedSlots) {
	this.occupiedSlots = occupiedSlots;
}
public ScheduleBean(String email, String date, String availableHours, String freeSlots, String occupiedSlots) {
	super();
	this.email = email;
	this.date = date;
	this.availableHours = availableHours;
	this.freeSlots = freeSlots;
	this.occupiedSlots = occupiedSlots;
}


}
