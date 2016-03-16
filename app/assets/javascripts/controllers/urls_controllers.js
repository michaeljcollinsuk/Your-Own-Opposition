UrlsApp.controller('UrlsController', ['$resource', function($resource) {
  var self = this;

  var suggestionsResource = $resource('http://localhost:3000/urls/1');
  var response = [];

  self.showBias = function() {
    self.loaded = true;
    suggestionsResource.get().$promise.then(function(data){
      self.response = data;
      console.log(self.response.current_bias);
    });
  };

  self.hideBias = function() {
    self.loaded = false;
  };

  self.showBreakDown = function(){
    self.furtherInfoLoaded = true;
    suggestionsResource.get().$promise.then(function(data){
      self.response = data.url_analysis;
      console.log(self.response);
  });
};

}]);
