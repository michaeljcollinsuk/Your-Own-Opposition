UrlsApp.controller('AnalysisController', ['$resource', '$http', 'suggestionFactory', 'analysisFactory', 'webhoseFactory', function($resource, $http, suggestionFactory, analysisFactory, webhoseFactory) {
  var self = this;
  self.showUserUrls = false;


  self.toggleShowRecentUrls = function() {
    self.showUserUrls = !self.showUserUrls;
  };

  self.showBias = function() {
    analysisFactory.analysisApiCall().$promise.then(function (response) {
      self.loaded = true;
      self.analysisResponse = response.bias.political_leaning;
      self.analysisResponseMessage = response.bias.bias_message;
    });
  };

  self.hideBias = function() {
    self.loaded = false;
  };

  self.showBreakDown = function(){
    analysisFactory.analysisApiCall().$promise.then(function(response){
      self.furtherInfoLoaded = true;
      self.sources = Object.keys(response.media_diet);
      self.percentageRead = analysisFactory.getPercentageRead(self.sources, response.media_diet);
  });

  self.hideBreakDown = function() {
    self.furtherInfoLoaded = false;
  };
};

 self.showSuggestions = function() {
   suggestionFactory.suggestionApiCall().$promise.then(function(response){
     self.suggestionsLoaded = true;
     self.papers = Object.keys(response.recommended_reading);
     self.newsSource = self.papers[0];
     self.topKeyword = response.best_topic[0];
     self.numberToRead = response.recommended_reading[self.papers[0]];
   });
 };

 self.getSuggestions = function() {
   self.suggestionsLoaded = false;
   self.searchingForLink = true;

   webhoseFactory.webhoseSuggestions(self.topKeyword, self.newsSource).$promise.then(function(response) {
    self.urlLinks = webhoseFactory.getUrlLinks(response.posts);
    self.articleImages = webhoseFactory.getArticleImages(response.posts);
    self.articleTitles = webhoseFactory.getArticleTitles(response.posts);
    self.quantity = self.numberToRead;
    self.articleLoaded = true;
    self.searchingForLink = false;
   });
 };

}]);
