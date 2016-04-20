UrlsApp.controller('analysisController', ['analysisFactory', function(analysisFactory) {
  var self = this;

  analysisFactory.analysisApiCall().$promise.then(function(response) {
    self.analysis = response;
    self.sources = analysisFactory.getSources(self.analysis.media_diet);
    self.percentageRead = analysisFactory.getPercentageRead(self.sources, self.analysis.media_diet);
    self.bias = analysisFactory.getBias(self.analysis);
  });
}]);
