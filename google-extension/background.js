// background.js

// Called when the user clicks on the browser action.
chrome.browserAction.onClicked.addListener(function(tab) {
  // Send a message to the active tab
  chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
    var activeTab = tabs[0];
    chrome.tabs.sendMessage(activeTab.id, {"message": "clicked_browser_action"});
    console.log("hi");
  });
});

// This block is new!
chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    if( request.message === "save_url" ) {
      chrome.tabs.create({"url_visited": request.params});
      // var client = new XMLHttpRequest();
      // client.open("POST", "/urls");
      // client.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
      // client.send(request.params);
      console.log(request.url_visited);
    }
  }
);
