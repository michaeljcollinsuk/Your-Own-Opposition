jQuery(function() {
    jQuery('.reminded').on('click', function(e){
        e.preventDefault();

        chrome.tabs.query({currentWindow: true, active: true}, function(tabs){
            var url         = tabs[0].url,
                date        = 1391048414,
                clientId    = 1234
            chrome.runtime.sendMessage({
                method: "POST",
                action: "xhttp",
                url: "http://www.API.com/endpoint",
                data: {url: url, date: date, clientId: clientId}
            }, function(responseText) {
                console.log(responseText);
            });
        });
    });
});
