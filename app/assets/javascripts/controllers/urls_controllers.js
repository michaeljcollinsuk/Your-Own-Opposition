UrlsApp.controller('UrlsController', ['$resource', function($resource) {
  var self = this;

  var analysisResource = $resource('http://localhost:3000/analysis');
  var analysisResponse = [];
  var breakdownResponse = [];
  var suggestionsResponse = [];
  var articles = [];

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
     self.suggestionsResponse = data.best_suggestion;
     self.keyword = Object.keys(self.suggestionsResponse)[0];
   });
 };

 self.hideSuggestions = function() {
   self.suggestionsLoaded = false;
 };


 var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20politics%20language%3A(english)%20thread.country%3AGB%20site%3A" + self.keyword + ".co.uk");

 // var webhoseResource = $resource('https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20politics%20language%3A(english)%20thread.country%3AGB%20site%3A' + self.suggestion + '.co.uk');

 self.articleLoaded = false;
 self.getSuggestions = function() {
   webhoseResource.get().$promise.then(function(data) {
     console.log(self.keyword);
     console.log(data);
     self.articles = data.posts[0].url;
     self.articleLoaded = true;
     console.log(self.articles);
   });
 };


}]);
