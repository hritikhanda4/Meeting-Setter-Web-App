var chatData = {
    vcObj                 : null,
    lastChatParticipant   : '',
    lastChatParticipantId : '',
    chatOpen              : false,
    numMissedMessages     : 0,
    lastMessage           : '',
    lastChatTime          : '',
    localParticipantId    : ''
};

// Handle Vidyo's group text chat
function handleChat(vidyoConnector) {
    // Suppresses form submission and calls sendChatMessage
    $("#messagingForm").submit(function(e) {
        e.preventDefault();
        sendChatMessage();
    });

    // When Enter is pressed in the messaging text area, send a message
    $("#msg").keypress(function(e) {
        if (e.which == 13) {
            // Let the carriage return be placed in the text area so when it is cleared, the message area returns to being empty
            setTimeout(function() {
                sendChatMessage();
            }, 0);
        }
    });

    chatData.vcObj = vidyoConnector;
    // Register for message/chat events
    vidyoConnector.RegisterMessageEventListener({
        onChatMessageReceived : function(participant, message) {
            var theText = message.body

            // The chat initial message "Time To VIDYO!" arrives with participant equal to null, just ignore
            if (participant === null) {
                return;
            }

            // Temporary workaround to stop self-messaging
            if (participant.name == $("#displayName").val() && theText == chatData.lastMessage) {
                return;
            }

            // If it's the same participant and last message was within the last minute append new message text to the same bubble
            var timestamp = getTimeStamp();
            if (participant.id == chatData.lastChatParticipantId && timestamp == chatData.lastChatTime) {
                mb = $("#message-box div:last-child");
                mb.find("#chatBody").append($('<p>' + theText + '</p>'));
            } else {
                // Create a new chat bubble with new message text
                var divOutter = $('<div class="talk-bubble other_talk round tri-right left-top"/>');
                var divHeader = $('<div class="headertext"/>').append($('<p>' + participant.name + ' ' + getTimeStamp() + '</p>'));
                var divBody = $('<div id="chatBody" class="talktext"/>').append($('<p>' + theText + '</p>' ));
                divOutter.append(divHeader);
                divOutter.append(divBody);
                $("#message-box").append(divOutter);
            }
            chatData.lastChatTime = timestamp;
            chatData.lastChatParticipant = participant.name;
            chatData.lastChatParticipantId = participant.id;
            if (!chatData.chatOpen) {
                chatData.numMissedMessages += 1;
                $("#new-message-notification").text(chatData.numMissedMessages.toString()).removeClass("hidden");
            }
            updateScroll();
        }
    });
}

// Respond to the chat button being clicked
function onChatButtonClicked() {
    if (chatData.chatOpen) {
        $("#myForm")[0].style.display = "none";
        $("#renderer").addClass("rendererWithoutChat").removeClass("rendererWithChat");
        chatData.numMissedMessages = 0;
    } else {
        $("#myForm")[0].style.display = "block";
        $("#renderer").removeClass("rendererWithoutChat").addClass("rendererWithChat");
        $("#new-message-notification").addClass("hidden").val('');
        chatData.numMissedMessages = 0;
        updateScroll();
        $("#chatTabButton").click();
    }
    chatData.chatOpen = !chatData.chatOpen;
}

// Open either the Chat or Participants tab
function openTab(event) {
    tabName = event.data.tabName;
    color = event.data.color;
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "#DDD";
    }
    document.getElementById(tabName).style.display="block";
    event.target.style.backgroundColor = color;
}

// Get's a new timestamp format HH:MM on a 12 hour clock
function getTimeStamp() {
    var time = new Date();
    hour = time.getHours()%12;
    minutes = time.getMinutes() < 10 ? '0' + time.getMinutes() : time.getMinutes();
    meridies = Math.floor(time.getHours()/12) == 1 ? "PM" : "AM";
    return hour + ":" + minutes + ' ' + meridies;
}

// Scrolls to the bottom of the message box
function updateScroll() {
    setTimeout(function() {
        var mb = $("#message-box")[0];
        mb.scrollTop = mb.scrollHeight;
    }, 0);
}

// Send chat message to other participants
function sendChatMessage() {
    var timestamp = getTimeStamp();
    var textBody = $.trim($("#msg").val());
    chatData.lastMessage = textBody;

    // Expand the bubble if you were the last one to send a message and the message was sent within the last minute
    if(chatData.lastChatTime == timestamp && chatData.lastChatParticipant == 'You'){
        mb = $("#message-box div:last-child");
        mb.find("#chatBody").append($('<p>' + textBody + '</p>' ));
    } else {
        // Create a new chat bubble and append the chat bubble to the message-box
        var divOutter = $('<div class="talk-bubble self_talk tri-right round right-top"/>');
        var divHeader = $('<div class="headertext"/>').append($('<p>You' + ' ' + getTimeStamp() + '</p>'));
        var divBody = $('<div id="chatBody" class="talktext"/>').append($('<p>' + textBody + '</p>' ));
        divOutter.append(divHeader);
        divOutter.append(divBody);
        $("#message-box").append(divOutter);
    }
    chatData.lastChatParticipant ='You';
    chatData.lastChatParticipantId = chatData.localParticipantId;
    chatData.lastChatTime = timestamp;

    // Send the chat message through the vidyoConnector
    if (chatData.vcObj !== null) {
        chatData.vcObj.SendChatMessage({message:textBody});
    }

    // Clear the message box
    $("#msg").val('');

    // Scroll to bottom of message box
    updateScroll();
}

// Set the local participant ID
function setLocalParticipantId(participantId) {
    chatData.localParticipantId = participantId;
}

// Reset the chat data
function resetChatData() {
    chatData.lastChatParticipant   = '',
    chatData.lastChatParticipantId = '',
    chatData.chatOpen              = false,
    chatData.numMissedMessages     = 0;
    chatData.lastMessage           = '',
    chatData.lastChatTime          = ''
    $("#message-box").empty();
}

