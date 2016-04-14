
UrlsApp.controller('AnalysisController', ['$resource', '$http', 'suggestionFactory', 'analysisFactory', 'webhoseFactory', function($resource, $http, suggestionFactory, analysisFactory, webhoseFactory) {
  var self = this;
  var analysisResponse = [];
  var analysisResponseMessage = "";
  var breakdownResponse = [];
  var sources = [];
  var percentageRead = [];
  var suggestionsResponse = [];
  var sourceSuggestion = [];
  var urlLinks = [];
  var articleImages = [];
  var articleTitles = [];
  var keywords = [];
  var keyword = "";
  var topicKeywords = [];
  var topKeywords = [];
  var mostRelevant = [];
  var topicValues = [];
  var numberToRead = [];
  var quantity = "";
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
    self.furtherInfoLoaded = true;
    analysisFactory.analysisApiCall().$promise.then(function(response){
      self.breakdownResponse = response.media_diet;
      self.sources = Object.keys(self.breakdownResponse);
      self.percentageRead = self.sources.map(function (key) {
                        return self.breakdownResponse[key];
                        });
  });

  self.hideBreakDown = function() {
    self.furtherInfoLoaded = false;
  };
};

var urlsResource = $resource('http://localhost:3000/urls');

 self.showSuggestions = function() {
   suggestionFactory.suggestionApiCall().$promise.then(function(response){
     self.suggestionsLoaded = true;
     self.suggestionData = response;
     self.papers = Object.keys(self.suggestionData.recommended_reading);
     self.newsSource = self.papers[0];
     self.topKeyword = response.best_topic[0];
     self.numberToRead = response.recommended_reading[self.papers[0]];
   });
 };

 self.articleLoaded = false;
 self.getSuggestions = function() {
   self.suggestionsLoaded = false;
   self.searchingForLink = true;

   webhoseFactory.webhoseSuggestions(self.topKeyword, self.newsSource).$promise.then(function(response) {
     self.articleLoaded = true;
     self.articles = response.posts;
     self.urlLinks = self.articles.map(function (article){
                      return article.url;
                      });
    self.articleImages = self.articles.map(function (article){
                     return article.thread.main_image;
                     });
    self.articleTitles = self.articles.map(function (article){
                     return article.title;
                     });
    self.quantity = self.numberToRead;
     self.searchingForLink = false;
   });
 };


}]);
