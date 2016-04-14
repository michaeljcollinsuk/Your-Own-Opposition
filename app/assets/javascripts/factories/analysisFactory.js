UrlsApp.factory('analysisFactory', ['$resource', function($resource) {
  self = {};

  var analysisResource = $resource('http://localhost:3000/analysis');

  self.analysisApiCall = function() {
    return analysisResource.get();
  };

  self.getPercentageRead = function(sources, mediaDiet) {
    return sources.map(function(key) {
      return mediaDiet[key];
    });
  };

  return self;
}]);
