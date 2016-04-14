UrlsApp.factory('webhoseFactory', ['$resource', function($resource) {
  self = {};


  self.webhoseSuggestions = function(topicKeyword, newsSource) {
    var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=" + topicKeyword + "%20site%3A"+ newsSource + ".co.uk");
    return webhoseResource.get();
  };

  self.getUrlLinks = function(webhoseData) {
    return webhoseData.map(function(article) {
      return article.url;
    });
  };

  self.getArticleImages = function(webhoseData) {
    return webhoseData.map(function(article) {
      return article.thread.main_image;
    });
  };

  self.getArticleTitles = function(webhoseData) {
    return webhoseData.map(function(article) {
      return article.title;
    });
  };

  return self;
}]);
