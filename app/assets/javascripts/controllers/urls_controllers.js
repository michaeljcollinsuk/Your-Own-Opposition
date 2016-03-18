
UrlsApp.controller('UrlsController', ['$resource', function($resource) {
  var self = this;

  var analysisResource = $resource('http://localhost:3000/analysis');
  var analysisResponse = [];
  var breakdownResponse = [];
  var sources = [];
  var percentageRead = [];
  var suggestionsResponse = [];
  var articleTitle = "";
  var articles = [];
  var img = "";
  var title = "";
  var urlLink = "";
  var keyword = "";
  var topicKeywords = [];
  var topKeywords = [];
  var mostRelevant = [];
  var topicValues = [];


  self.showRecentUrls = function() {
    self.userUrlsLoaded = true;
  };

  self.hideRecentUrls = function(){
    self.userUrlsLoaded = false;
  };

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
      self.sources = Object.keys(self.breakdownResponse);
      self.percentageRead =
      self.sources.map(function (key) {
      return self.breakdownResponse[key];
  });


  });

  self.hideBreakDown = function() {
    self.furtherInfoLoaded = false;
  };
};

var suggestionsResource = $resource('http://localhost:3000/suggestions');
var urlsResource = $resource('http://localhost:3000/urls');


 self.showSuggestions = function() {
   self.suggestionsLoaded = true;
   suggestionsResource.get().$promise.then(function(data){
     self.topicSuggestionsResponse = data.url_analysis.top_topics;
     self.suggestionsResponse = data.best_suggestion;
     self.keyword = Object.keys(self.suggestionsResponse)[0];
     self.topicKeyword = Object.keys(data.url_analysis.top_topic)[0];
   });
 };


 self.articleLoaded = false;
 self.getSuggestions = function() {
   self.suggestionsLoaded = false;
   self.searchingForLink = true;
  var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20" + self.topicKeyword + "%20site%3A"+ self.keyword + ".co.uk");
   webhoseResource.get().$promise.then(function(data) {
     self.articles = data.posts;
     self.urlLink = data.posts[0].url;
     self.image = data.posts[0].img;
     self.articleTitle = data.posts[0].title;
     self.articleLoaded = true;
     self.searchingForLink = false;
   });
 };


}]);
