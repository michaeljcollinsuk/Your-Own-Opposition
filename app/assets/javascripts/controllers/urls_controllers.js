UrlsApp.controller('UrlsController', ['$resource', function($resource) {
  var self = this;

  var analysisResource = $resource('http://localhost:3000/analysis');
  var analysisResponse = [];
  var breakdownResponse = [];
  var suggestionsResponse = [];

  self.showBias = function() {
    self.loaded = true;
    analysisResource.get().$promise.then(function(data){
      self.analysisResponse = data.current_bias;
    });
  };

  self.hideBias = function() {
    self.loaded = false;
  };

  self.showBreakDown = function(){
    self.furtherInfoLoaded = true;
    analysisResource.get().$promise.then(function(data){
      self.breakdownResponse = data.media_diet;
  });

  self.hideBreakDown = function() {
    self.furtherInfoLoaded = false;
  };
};

 var suggestionsResource = $resource('http://localhost:3000/suggestions');

 self.showSuggestions = function() {
   self.suggestionsLoaded = true;
   suggestionsResource.get().$promise.then(function(data){
     self.suggestionsResponse = data;
   });
 };

}]);
