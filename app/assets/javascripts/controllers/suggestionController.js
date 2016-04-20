UrlsApp.controller('suggestionController', ['suggestionFactory', 'webhoseFactory', function(suggestionFactory, webhoseFactory) {
  var self = this;

  self.showSuggestions = function() {
    suggestionFactory.suggestionApiCall().$promise.then(function(response){
      self.suggestionsLoaded = true;
      self.recommendedReading = response.recommended_reading;
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
     self.articleLoaded = true;
     self.searchingForLink = false;
    });
  };

}]);
