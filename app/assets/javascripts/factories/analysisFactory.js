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

  self.getBias = function(analysis) {
    return analysis.bias;
  };

  self.getSources = function(media_diet) {
    return Object.keys(media_diet);
  };

  return self;
}]);
