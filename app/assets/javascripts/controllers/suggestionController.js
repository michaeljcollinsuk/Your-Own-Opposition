UrlsApp.controller('suggestionController', ['suggestionFactory', 'webhoseFactory', function(suggestionFactory, webhoseFactory) {
  var self = this;
  suggestionFactory.suggestionApiCall().$promise.then(function(response){
    self.suggestions = response;
  });

  self.showSuggestions = function() {
    self.suggestionsLoaded = true;
    self.papers = Object.keys(self.suggestions.recommended_reading);
  };

  self.getSuggestions = function() {
    self.suggestionsLoaded = false;
    self.searchingForLink = true;

    webhoseFactory.webhoseSuggestions(self.suggestions.best_topic[0], self.papers[0]).$promise.then(function(response) {
     self.urlLinks = webhoseFactory.getUrlLinks(response.posts);
     self.articleImages = webhoseFactory.getArticleImages(response.posts);
     self.articleTitles = webhoseFactory.getArticleTitles(response.posts);
     self.articleLoaded = true;
     self.searchingForLink = false;
    });
  };

}]);
