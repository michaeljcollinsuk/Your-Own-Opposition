UrlsApp.factory('webhoseFactory', ['$resource', function($resource) {
  self = {};


  self.webhoseSuggestions = function(topicKeyword, newsSource) {
    var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20" + topicKeyword + "%20site%3A"+ newsSource + ".co.uk");
    return webhoseResource.get();
  };

  return self;
}]);
