UrlsApp.factory('suggestionFactory', ['$resource', function($resource) {
  self = {};

  var suggestionsResource = $resource('http://localhost:3000/suggestions');

  self.suggestionApiCall = function() {
    return suggestionsResource.get();
  };

  return self;
}]);
