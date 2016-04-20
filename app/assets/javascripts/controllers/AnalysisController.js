UrlsApp.controller('analysisController', ['analysisFactory', function(analysisFactory) {
  var self = this;
  self.showUserUrls = false;

  analysisFactory.analysisApiCall().$promise.then(function(response) {
    self.analysis = response;
  });

  self.toggleShowRecentUrls = function() {
    self.showUserUrls = !self.showUserUrls;
  };

  self.showBias = function() {
      self.loaded = true;
      self.bias = analysisFactory.getBias(self.analysis);
  };

  self.hideBias = function() {
    self.loaded = false;
  };

  self.showBreakDown = function(){
    self.furtherInfoLoaded = true;
    self.sources = analysisFactory.getSources(self.analysis.media_diet);
    self.percentageRead = analysisFactory.getPercentageRead(self.sources, self.analysis.media_diet);
  };

  self.hideBreakDown = function() {
    self.furtherInfoLoaded = false;
  };

}]);
