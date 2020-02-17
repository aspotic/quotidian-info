var applicationID = '6a0e1772-c753-49b8-bd1a-4d865cf876f1';
var castApi;
var currentActivityId = null;
var currentReceiver;
var receivers = [];

// Setup cast api
if (window.cast && window.cast.isAvailable) {
    // Already initialized
    initializeCastApi();
} else {
    // Wait for API to post a message to us
    window.addEventListener("message", function(event) {
        if (event.source == window && event.data && event.data.source == "CastApi" && event.data.event == "Hello"){
            initializeCastApi();
        }
    });
};


// Open up the cast api and set the operation done when a receiver connects
initializeCastApi = function() {
  castApi = new cast.Api();
  castApi.addReceiverListener(applicationID, onReceiverList);
};


// Populates a window with available receivers
function onReceiverList(list) {
    console.log("receiver list" + list);
    var receiverDiv = document.getElementById('receivers');
    var temp = '';

    for(var i=0; i < list.length; i++) {
        receivers.push(list[i]);
        temp += "<button onClick='gotoUrl(" + i + ")' id='cast" + list[i].id + "'>" + list[i].name + "</button><br />";
    }
    receiverDiv.innerHTML = temp;
}


//
function gotoUrl(i) {
    if(currentActivityId) return;

    console.log("casting url to " + receivers[i]);
    currentReceiver = receivers[i];

    var launchRequest = new cast.LaunchRequest(applicationID, receivers[i]);
    launchRequest.parameters = document.getElementById('url').value;
    launchRequest.description = new cast.LaunchDescription();
    launchRequest.description.text = "Displaying Via Sender App";

   //webViewer-custom-protocol

    var resultCallback = function(status) {
        if (status.status == 'running') {
            console.log('Launch succeeded: ' + status);
            currentActivityId = status.activityId;
            //castApi.sendMessage(currentActivityId, "", function(response) { alert(response); });
        } else {
            console.log('Launch failed: ' + status.errorString);
        }
    };

    castApi.addMessageListener(currentActivityId, "namespace", function(event){console.log(event)});
    castApi.launch(launchRequest, resultCallback);
}


//
function sendMessage(message) {
    castApi.sendMessage(currentActivityId, "namespace", message, function(event){console.log(event);})
}