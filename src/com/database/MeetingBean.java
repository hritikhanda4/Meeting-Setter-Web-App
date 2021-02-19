package com.database;

public class MeetingBean {
private String roomId;
private String password;
private String token;
private String username;



public MeetingBean() {
	super();
}



public MeetingBean(String roomId, String password, String token, String username) {
	super();
	this.roomId = roomId;
	this.password = password;
	this.token = token;
	this.username = username;
}








public String getRoomId() {
	return roomId;
}
public void setRoomId(String roomId) {
	this.roomId = roomId;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getToken() {
	return token;
}
public void setToken(String token) {
	this.token = token;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}


}
