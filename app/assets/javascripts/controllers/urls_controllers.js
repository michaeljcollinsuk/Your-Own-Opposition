
UrlsApp.controller('UrlsController', ['$resource', function($resource) {
  var self = this;

  var analysisResource = $resource('http://localhost:3000/analysis');
  var analysisResponse = [];
  var breakdownResponse = [];
  var sources = [];
  var percentageRead = [];
  var suggestionsResponse = [];
  var articles = [];
  var img = "";
  var urlLink = "";
  var keyword = "";

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
  debugger;

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
     self.suggestionsResponse = data.best_suggestion;
     self.keyword = Object.keys(self.suggestionsResponse)[0];
   });
 };


 self.articleLoaded = false;
 self.getSuggestions = function() {
   self.suggestionsLoaded = false;
   self.searchingForLink = true;
  var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20site%3A"+ self.keyword + ".co.uk");
   webhoseResource.get().$promise.then(function(data) {
     self.articles = data.posts;
     self.urlLink = self.articles[0].url;
     self.image = data.posts[0].img;
     self.articleLoaded = true;
     self.searchingForLink = false;
   });
 };


}]);

// self.saveThis = function() {
//   self.suggestionsLoaded = true;
//   self.searchingForLink = true;
//   self.articleLoaded = false;
//  var webhoseResource = $resource("https://webhose.io/search?token=b68bbb9d-dd4d-4179-95c1-d60a3cdbd303&format=json&q=politics%20site%3A"+ self.keyword + ".co.uk");
//   webhoseResource.get().$promise.then(function(data) {
//    //  console.log(self.keyword);
//     self.articles = data.posts[0].url;
//     self.articles.$save()
//     urlsResource.post().$promise.then(function(data){
//
//     });
//
//    //  self.articleLoaded = true;
//    //  self.searchingForLink = false;
//    //  console.log(self.articles);
//   });
// };

// var cards = CreditCard.query(function() {
//   // GET: /user/123/card
//   // server returns: [ {id:456, number:'1234', name:'Smith'} ];
//
//   var card = cards[0];
//   // each item is an instance of CreditCard
//   expect(card instanceof CreditCard).toEqual(true);
//   card.name = "J. Smith";
//   // non GET methods are mapped onto the instances
//   card.$save();
//   // POST: /user/123/card/456 {id:456, number:'1234', name:'J. Smith'}
//   // server returns: {id:456, number:'1234', name: 'J. Smith'};
//
//   // our custom method is mapped as well.
//   card.$charge({amount:9.99});
//   // POST: /user/123/card/456?amount=9.99&charge=true {id:456, number:'1234', name:'J. Smith'}
// });
