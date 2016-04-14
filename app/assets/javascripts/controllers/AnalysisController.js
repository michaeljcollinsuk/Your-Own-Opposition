
UrlsApp.controller('AnalysisController', ['$resource', '$http', 'suggestionFactory', 'analysisFactory', function($resource, $http, suggestionFactory, analysisFactory) {
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
    self.loaded = true;
    analysisFactory.analysisApiCall().$promise.then(function (response) {
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
   self.suggestionsLoaded = true;
   suggestionFactory.suggestionApiCall().$promise.then(function(response){
     self.suggestionData = response;
     self.papers = Object.keys(self.suggestionData.recommended_reading);
   });
 };


 self.articleLoaded = false;
 self.getSuggestions = function() {
   self.suggestionsLoaded = false;
   self.searchingForLink = true;

  var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20" + self.topicKeyword + "%20site%3A"+ self.keyword + ".co.uk");
   webhoseResource.get().$promise.then(function(data) {

     self.articleLoaded = true;
     self.articles = data.posts;
     self.urlLinks = self.articles.map(function (article){
                      return article.url;
                      });
    self.articleImages = self.articles.map(function (article){
                     return article.thread.main_image;
                     });
    self.articleTitles = self.articles.map(function (article){
                     return article.title;
                     });
    self.quantity = self.numberToRead[0] - 1;
     self.searchingForLink = false;
   });
 };




}]);
