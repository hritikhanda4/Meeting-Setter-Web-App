<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.database.*"%>
    <%
    MeetingBean mb=(MeetingBean) session.getAttribute("userMeeting");
    if(mb==null)
    	response.sendRedirect("500error");
    %>
<!DOCTYPE html>
<html>
<head>
	<title>Meeting Room</title>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<script>if (typeof module === 'object') {window.module = module; module = undefined;}</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="jquery-3.1.1.min.js"><\/script>')</script>
	<script>if (window.module) module = window.module;</script>

	<!-- We've provide some simple styling to get you started. -->
	<link href="VidyoConnector.css" rel="stylesheet" type="text/css" >
	<link href="VidyoTextChat.css" rel="stylesheet" type="text/css" >

	<style>
		#speakerButton:hover,#chatButton:hover,#cameraButton:hover,#microphoneButton:hover,#joinLeaveButton:hover,#cameraButton:hover{
			background-color:rgb(27, 27, 139);
		}
		</style>

	<!-- Here we load the application which knows how to
	invoke the VidyoConnector API. -->
	<script src="VidyoConnector.js"></script>
	<script src="VidyoTextChat.js"></script>
	
	
	<script type="text/javascript">
	
	var configParams = {};
	var platformInfo = {};
	var webrtcExtensionPath = "";
	var webrtcInitializeAttempts = 0;

	function onVidyoClientLoaded(status) {
		console.log("Status: " + status.state + "Description: " + status.description);
		switch (status.state) {
			case "READY":    // The library is operating normally
				$("#connectionStatus").html("Ready to Connect");
				$("#helper").addClass("hidden");
				$("#optionsVisibilityButton").removeClass("hidden");
				$("#renderer").removeClass("hidden");
				$("#toolbarLeft").removeClass("hidden");
				$("#toolbarCenter").removeClass("hidden");
				$("#toolbarRight").removeClass("hidden");

				// If configured to autoJoin, then show video full screen immediately
				if (configParams.autoJoin === "1") {
					$("#optionsVisibilityButton").addClass("showOptions").removeClass("hideOptions");
					$("#renderer").addClass("rendererWithoutOptions").removeClass("rendererWithOptions");
				} else
					$("#options").removeClass("hidden");

				// If WebRTC is being used, specify the screen share extension path.
				if (VCUtils.params.webrtc === "true") {
					if (status.hasOwnProperty("downloadPathWebRTCExtensionFirefox"))
						webrtcExtensionPath = status.downloadPathWebRTCExtensionFirefox;
					else if (status.hasOwnProperty("downloadPathWebRTCExtensionChrome"))
						webrtcExtensionPath = status.downloadPathWebRTCExtensionChrome;
				}

				// Determine which Vidyo stack will be used: Native WebRTC, Transcoding WebRTC or Native (Plugin/Electron)
				var useTranscodingWebRTC, performMonitorShare;
				if (status.description.indexOf("Native XMPP + WebRTC") > -1) {
					// Native WebRTC
					useTranscodingWebRTC = false;
					performMonitorShare  = false;
				} else if (status.description.indexOf("WebRTC successfully loaded") > -1) {
					// Transcoding WebRTC
					useTranscodingWebRTC = true;
					performMonitorShare  = false;
					++webrtcInitializeAttempts;
				} else {
					// Native (Plugin or Electron)
					useTranscodingWebRTC = false;
					performMonitorShare  = true;
				}

				// After the VidyoClient is successfully initialized a global VC object will become available
				// All of the VidyoConnector gui and logic is implemented in VidyoConnector.js
				StartVidyoConnector(VC, useTranscodingWebRTC, performMonitorShare, webrtcExtensionPath, configParams);

				break;
			case "RETRYING": // The library operating is temporarily paused
				$("#connectionStatus").html("Temporarily unavailable retrying in " + status.nextTimeout/1000 + " seconds");
				break;
			case "FAILED":   // The library operating has stopped
				// If WebRTC initialization failed, try again up to 3 times.
				if ((status.description.indexOf("Could not initialize WebRTC transport") > -1) && (webrtcInitializeAttempts < 3)) {
					// Attempt to start the VidyoConnector again.
					StartVidyoConnector(VC, VCUtils.params.webrtc, webrtcExtensionPath, configParams);
					++webrtcInitializeAttempts;
				} else {
					ShowFailed(status);
				}
				break;
			case "FAILEDVERSION":   // The library operating has stopped
				UpdateHelperPaths(status);
				ShowFailedVersion(status);
				$("#connectionStatus").html("Failed: " + status.description);
				break;
			case "NOTAVAILABLE": // The library is not available
				UpdateHelperPaths(status);
				$("#connectionStatus").html(status.description);
				break;
            case "TIMEDOUT":   // Transcoding Inactivity Timeout
                $("#connectionStatus").html("Failed: " + status.description);
                $("#messages #error").html('Page timed out due to inactivity. Please refresh your browser and try again.');
                break;
		}
		return true; // Return true to reload the plugins if not available
	}
	function UpdateHelperPaths(status) {
		$("#helperPlugInDownload").attr("href", status.downloadPathPlugIn);
		$("#helperAppDownload").attr("href", status.downloadPathApp);
	}
	function ShowFailed(status) {
		var helperText = '';
		 // Display the error
		helperText += '<h2>An error occurred, please reload</h2>';
		helperText += '<p>' + status.description + '</p>';

		$("#helperText").html(helperText);
		$("#failedText").html(helperText);
		$("#failed").removeClass("hidden");
		$("#connectionStatus").html("Failed: " + status.description);
		$("#optionsVisibilityButton").addClass("hidden");
		$("#options").addClass("hidden");
	}
	function ShowFailedVersion(status) {
		var helperText = '';
		 // Display the error
		helperText += '<h4>Please Download a new plugIn and restart the browser</h4>';
		helperText += '<p>' + status.description + '</p>';

		$("#helperText").html(helperText);
	}

	function loadVidyoClientLibrary(webrtc, plugin) {
		// If webrtc, then set webrtcLogLevel
		var webrtcLogLevel = "";
		if (webrtc) {
			// Set the WebRTC log level to either: 'info' (default), 'error', or 'none'
			if (configParams.webrtcLogLevel === 'info' || configParams.webrtcLogLevel === 'error' || configParams.webrtcLogLevel == 'none')
				webrtcLogLevel = '&webrtcLogLevel=' + configParams.webrtcLogLevel;
			else
				webrtcLogLevel = '&webrtcLogLevel=info';
		}

		//We need to ensure we're loading the VidyoClient library and listening for the callback.
		var script = document.createElement('script');
		script.type = 'text/javascript';
		script.src = 'https://static.vidyo.io/latest/javascript/VidyoClient/VidyoClient.js?onload=onVidyoClientLoaded&webrtc=' + webrtc + '&plugin=' + plugin + webrtcLogLevel;
		document.getElementsByTagName('head')[0].appendChild(script);
	}
	function joinViaBrowser() {
		// document.getElementById("#displayNameJoin").hide();
		// document.getElementById("#resourceIdJoin").hide();
		$("#displayNameJoin").hide();
		$("#resourceIdJoin").hide();

		$("#helperText").html("Loading...");
		$("#helperPicker").addClass("hidden");
		$("#monitorShareParagraph").addClass("hidden");
		loadVidyoClientLibrary(true, false);
	}

	function loadAppFromProtocolHandler(forceRedirect) {
		var protocolHandlerLink = 'vidyoconnector://' + window.location.search;

		if (platformInfo.isiOS || platformInfo.isAndroid || forceRedirect) {
			window.open(protocolHandlerLink, '_self');
		} else {
			$('body').append("<iframe src='" + protocolHandlerLink + "' style='width:0;height:0;border:0; border:none;'></iframe>");
		}
	}
	function loadPlatformInfo(platformInfo) {
		var userAgent = navigator.userAgent || navigator.vendor || window.opera;
		// Opera 8.0+
		platformInfo.isOpera = userAgent.indexOf("Opera") != -1 || userAgent.indexOf('OPR') != -1 ;
		// Firefox
		platformInfo.isFirefox = userAgent.indexOf("Firefox") != -1 || userAgent.indexOf('FxiOS') != -1 ;
		// Chrome 1+
		platformInfo.isChrome = userAgent.indexOf("Chrome") != -1 || userAgent.indexOf('CriOS') != -1 ;
		// Safari
		platformInfo.isSafari = !platformInfo.isFirefox && !platformInfo.isChrome && userAgent.indexOf("Safari") != -1;
		// AppleWebKit
		platformInfo.isAppleWebKit = !platformInfo.isSafari && !platformInfo.isFirefox && !platformInfo.isChrome && userAgent.indexOf("AppleWebKit") != -1;
		// Internet Explorer 6-11
		platformInfo.isIE = (userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true );
		// Edge 20+
		platformInfo.isEdge = !platformInfo.isIE && !!window.StyleMedia;
		// Check if Mac
		platformInfo.isMac = navigator.platform.indexOf('Mac') > -1;
		// Check if Windows
		platformInfo.isWin = navigator.platform.indexOf('Win') > -1;
		// Check if Linux
		platformInfo.isLinux = navigator.platform.indexOf('Linux') > -1;
		// Check if iOS
		platformInfo.isiOS = userAgent.indexOf("iPad") != -1 || userAgent.indexOf('iPhone') != -1 ;
		// Check if Android
		platformInfo.isAndroid = userAgent.indexOf("android") > -1;
		// Check if Electron
		platformInfo.isElectron = (typeof process === 'object') && process.versions && (process.versions.electron !== undefined);
		// Check if WebRTC is available
		platformInfo.isWebRTCAvailable = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || (navigator.mediaDevices ? navigator.mediaDevices.getUserMedia : undefined)) ? true : false;
		// Check if 64bit
		platformInfo.is64bit = navigator.userAgent.indexOf('WOW64') > -1 ||  navigator.userAgent.indexOf('Win64') > -1 || window.navigator.platform == 'Win64';	
	}
	
	function loadHelperOptions(platformInfo) {
		if (!platformInfo.isMac && !platformInfo.isWin && !platformInfo.isLinux) {
			/* Mobile App*/
			if (platformInfo.isAndroid || platformInfo.isiOS) {
				$("#joinViaApp").removeClass("hidden");
			} else {
				$("#joinViaOtherApp").removeClass("hidden");
			}
			if (platformInfo.isWebRTCAvailable) {
				/* Supports WebRTC */
				$("#joinViaBrowser").removeClass("hidden");
			}
		} else {
			/* Desktop App */
			$("#joinViaApp").removeClass("hidden");

			if (platformInfo.isWebRTCAvailable) {
				/* Supports WebRTC */
				$("#joinViaBrowser").removeClass("hidden");
			}
			if (platformInfo.isSafari || (platformInfo.isAppleWebKit && platformInfo.isMac) || (platformInfo.isIE && !platformInfo.isEdge)) {
				/* Supports Plugins */
				$("#joinViaPlugIn").removeClass("hidden");
			}
		}
	}

	// Runs when the page loads
	$(function() {	            
	
		var connectorType = getUrlParameterByName("connectorType");
		loadPlatformInfo(platformInfo);

		// Extract the desired parameter from the browser's location bar
		function getUrlParameterByName(name) {
			var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
			return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
		}

		// Fill in the form parameters from the URI
		var host = "prod.vidyo.io";
		if (host)
			$(".host").val(host);
		var token = <%="\""+ mb.getToken().toString() +"\""%>;
			//"cHJvdmlzaW9uAGhyaXRpa2hhbmRhNEAxYmU1MWYudmlkeW8uaW8ANjM3Njk5MzM2MDgAADJiYzYxYmY0ODIzOWQ2MDMwNjA3MDU3NTVkZGY4Y2VmYTdkMGRmMDE5OWQ1MTNmMWYyNzU0YTQ2YjMyYzE0OTIxNzI3MzI3OWE0ODA5ZGM2YjhkYTE1ZTZlNjAyZDIzZQ==";
		
		if (token)
			$(".token").val(token);
		var displayName =<%="\""+mb.getUsername().toString()+"\""%>;
		if (displayName)
			$(".displayName").val(displayName);
		var resourceId = <%="\""+mb.getRoomId().toString()+"\""%>;
		if (resourceId)
			$(".resourceId").val(resourceId);
		configParams.autoJoin    = getUrlParameterByName("autoJoin");
		configParams.enableDebug = getUrlParameterByName("enableDebug");
		configParams.microphonePrivacy = getUrlParameterByName("microphonePrivacy");
		configParams.cameraPrivacy = getUrlParameterByName("cameraPrivacy");
		configParams.speakerPrivacy = getUrlParameterByName("speakerPrivacy");
		configParams.webrtcLogLevel = getUrlParameterByName("webrtcLogLevel");
		configParams.returnURL = getUrlParameterByName("returnURL");
		configParams.isIE = platformInfo.isIE;
		var hideConfig = getUrlParameterByName("hideConfig");

		// If the parameters are passed in the URI, do not display options dialog
		if (host && token && displayName && resourceId) {
			$(".optionsParameters").addClass("hiddenPermanent");
		}

		if (hideConfig=="1") {
			$("#options").addClass("hiddenPermanent");
			$("#optionsVisibilityButton").addClass("hiddenPermanent");
			$("#renderer").addClass("rendererWithoutOptionsPermanent");
		}

		if (connectorType == "app") {
			joinViaApp();
		} else if (connectorType == "browser") {
			joinViaBrowser();
		} else if (connectorType == "plugin") {
			joinViaPlugIn();
		} else if (connectorType == "other") {
			joinViaOtherApp();
		} else if (platformInfo.isElectron) {
			joinViaElectron();
		} else {
			loadHelperOptions(platformInfo);
		}
		
		joinViaBrowser();
	});
	</script>
	
</head>

<!-- We execute the VidyoConnectorApp library on page load
to hook up all of the events to elements. -->
<body id="vidyoConnector" >
	<!-- This button toggles the visibility of the options. -->
	<button id="optionsVisibilityButton" title="Toggle Options" class="optionsVisibiliyButtonElements hideOptions hidden"></button>

	<div id="options" class="options hidden">
		<img class="logo" src="Images/VidyoIcon.png"/>

		<form>
		<div class="optionsParameters">
		<p hidden>
			<!-- The host of our backend service. -->
			<label>Host</label>
			<input type="text" id="host" class="host" value="prod.vidyo.io">
		</p>
		<p hidden>
			<!-- A token that is derived from the deveoper key assigned to your account which will allow access for this particular instance.
			The token will contain its expiration date and the user ID.
			For more information visit the developer section of http://vidyo.io -->
			<label>Token</label>
			<input type="text" id="token" class="token" placeholder="ACCESS-TOKEN" value="">
		</p>
		<p>
			<!-- This is the display name that other users will see.
			-->
			<label for="displayName">Display Name</label>
			<input disabled id="displayName" class="displayName" type="text" placeholder="Display Name" value="Guest">
		</p>
		<p>
			<!-- This is the "room" or "space" to which you're connecting
			the user. Other users who join this same Resource will be able to see and hear each other.
			-->
			<label for="resourceId">Room ID</label>
			<input disabled id="resourceId" class="resourceId" type="text" placeholder="Conference Reference" value="demoRoom">
		</p>
		</div>
		<p>
			<!-- This is the display name that other users will see.
			-->
			<label for="displayName">Display Name</label>
			<input disabled id="displayName" class="displayName" type="text" placeholder="Display Name" value="Guest">
		</p>
		<p>
			<!-- This is the "room" or "space" to which you're connecting
			the user. Other users who join this same Resource will be able to see and hear each other.
			-->
			<label for="resourceId">Room ID</label>
			<input disabled id="resourceId" class="resourceId" type="text" placeholder="Conference Reference" value="demoRoom">
		</p>
		<p>
			<!-- On page load, this input is filled with a list of all the available cameras on the user's system. -->
			<label for="cameras">Camera</label>
			<select id="cameras">
				<option value='0'>None</option>
			</select>
		</p>
		<p>
			<!-- On page load, this input is filled with a list of all the available microphones on the user's system. -->
			<label for="microphones">Microphone</label>
			<select id="microphones">
				<option value='0'>None</option>
			</select>
		</p>
		<p>
			<!-- On page load, this input is filled with a list of all the available microphones on the user's system. -->
			<label for="speakers">Speaker</label>
			<select id="speakers">
				<option value='0'>None</option>
			</select>
		</p>
		<p id="monitorShareParagraph">
			<!-- On page load, this input is filled with a list of all the available monitor shares on the user's system. -->
			<label for="monitorShares">Monitor Share</label>
			<select id="monitorShares">
				<option value='0'>None</option>
			</select>
		</p>
		<p>
			<!-- On page load, this input is filled with a list of all the available window shares on the user's system. -->
			<label for="windowShares">Window Share</label>
			<select id="windowShares">
				<option value='0'>None</option>
			</select>
		</p>
		
<p>
	<a style=" background:linear-gradient(90deg, rgba(31,19,235,1) 0%, rgba(9,19,121,1) 20%, rgba(140,0,255,1) 100%);
    height: 40px;
    width: 250px;
	padding-left: 40px;

	padding-right: 40px;
	padding-top: 10px;
	padding-bottom: 10px;
    position: relative;
    left: 10px;
    border-radius: 10px;
    top: 15px;
    color:white;
    font-size: 20px;
	outline: none;text-decoration: none;" href="joinMeeting">EXIT</a>	
	
	
		</p>

		</form>
		<div style="position: relative;left: 0px;top: -320px;" id="messages">
			<!-- All Vidyo-related messages will be inserted into these spans. -->
			<span id="error"></span>
			<span id="message"></span>
		</div>
	</div>
	<!-- This is the div into which the Vidyo component will be inserted. -->
	<div id="renderer" class="rendererWithOptions pluginOverlay hidden rendererWithoutChat">
	</div>
	<div id="toolbarLeft" class="toolbar hidden">
		<span id="participantStatus"></span>
	</div>
	<div id="toolbarRight" class="toolbar hidden">
		<span id="connectionStatus">Initializing</span>
		<span id="clientVersion"></span>
	</div>
	<div id="toolbarCenter" class="toolbar hidden">
		<!-- This button toggles the speaker privacy on or off. -->
		<button id="speakerButton" title="Speaker Privacy" class="toolbarButton speakerOn"></button>

		<!-- This button mutes and unmutes the users' microphone. -->
		<button id="microphoneButton" title="Microphone Privacy" class="toolbarButton microphoneOn"></button>

		<!-- This button joins and leaves the conference. -->
		<button id="joinLeaveButton" title="Join Conference" class="toolbarButton callStart"></button>

		<!-- This button toggles the camera privacy on or off. -->
		<button id="cameraButton" title="Camera Privacy" class="toolbarButton cameraOn"></button>

		<!-- This button toggles the chat window. -->
		<button id="chatButton" title="Toggle Chat" class="notification toolbarButton chaticon">
			<span class="badge hidden" id="new-message-notification"></span>
		</button>
	</div>
	<div id="helper">
		<table>
			<tr>
				<td><img style="position: relative;left:-5px;top: 25px;" class="logo" src="Images/VidyoIO-LogoHorizontal-Dark@2x.png"/></td>
			</tr>
			<tr>
				<td id="helperText">Your credentials are : ?</td>
			</tr>
			<tr>
				<td><input style="position: relative;left:-5px;top: 50px;top: 0px;width: 200px;height:40px;padding-left: 30px;border:1px black solid;border-radius: 25px;" disabled id="displayNameJoin" class="displayName" type="text" placeholder="Display Name" value="Guest"></td>
			</tr>
				<td><input style="position: relative;left:-5px;top: 50px;top: 0px;width: 200px;height:40px;padding-left: 30px;border:1px black solid;border-radius: 25px;" disabled id="resourceIdJoin" class="resourceId" type="text" placeholder="Conference Reference" value="demoRoom"></td>
			</tr>
			
			
		</table>
	</div>
	<div id="failed" class="hidden">
		<table>
			<tr>
				<td><img   class="logo" src="Images/VidyoIcon.png"/></td>
			</tr>
			<tr>
				<td id="failedText">Error</td>
			</tr>
		</table>
	</div>

	<div class="chat-popup" id="myForm">
		<button id="chatTabButton" class="tablink">Chat</button>
		<button id="participantTabButton" class="tablink participantTabLink">Participants</button>
		<div class="tabcontent", id="participantTab">
			<table id="participantTable" class="ParticipantTable">
			</table>
		</div>
		<div class="tabcontent" id="chatTab">
			<div class="message-container" id="message-box">
			</div>
			<form onsubmit="return false;" id="messagingForm" class="form-container">
				<textarea placeholder="Type message.." name="msg" id="msg" required></textarea>
				<br/>
				<button type="submit" class="btn">Send</button>
			</form>
		</div>
	</div>
	
	
	
	
	
</body>
</html>
