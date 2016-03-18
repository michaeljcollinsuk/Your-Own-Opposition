
// console.log(window.location.protocol + "//" + window.location.host + "/" + window.location.pathname);

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    if( request.message === "clicked_browser_action" ) {
      var thisHref = (window.location.protocol + "//" + window.location.host + "/" + window.location.pathname);

      console.log(thisHref);

      // This line is new!
      // chrome.runtime.sendMessage();
      chrome.runtime.sendMessage({
          "message": "save_url",
          "url_visited": thisHref,
          method: "POST",
          action: "xhttp",
          url: "http://localhost:3000/urls",
          params: {"url": {"link": thisHref}, "commit": "Create Url"}
      }, function() {
          console.log(thisHref);
 //          
// }
      });
    }
  }
);

// chrome.tabs.query({currentWindow: true, active: true}, function(tabs){
//     var url         = tabs[0].url,
//         date        = 1391048414,
//         clientId    = 1234
