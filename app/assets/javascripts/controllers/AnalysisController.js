UrlsApp.controller('analysisController', ['analysisFactory', function(analysisFactory) {
  var self = this;
  self.showUserUrls = false;


  self.toggleShowRecentUrls = function() {
    self.showUserUrls = !self.showUserUrls;
  };

  self.showBias = function() {
    analysisFactory.analysisApiCall().$promise.then(function(response) {
      self.loaded = true;
      self.analysisResponse = response.bias.political_leaning;
      self.analysisResponseMessage = response.bias.bias_message;
    });
  };

  self.hideBias = function() {
    self.loaded = false;
  };

  self.showBreakDown = function(){
    analysisFactory.analysisApiCall().$promise.then(function(response) {
      self.furtherInfoLoaded = true;
      self.sources = Object.keys(response.media_diet);
      self.percentageRead = analysisFactory.getPercentageRead(self.sources, response.media_diet);
  });

  self.hideBreakDown = function() {
    self.furtherInfoLoaded = false;
  };
};

}]);
