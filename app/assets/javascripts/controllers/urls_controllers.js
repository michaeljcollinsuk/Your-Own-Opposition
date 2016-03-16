var UrlsApp = angular.module('UrlsApp', []);


UrlsApp.controller('UrlsController', function() {
  var self = this;

  self.showBias = function() {
    self.name = 'barry';
  };

});
