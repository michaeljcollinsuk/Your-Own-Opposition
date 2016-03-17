describe('UrlsApp', function(){
  it('has something', function(){
    browser.get('http://localhost:8080');

    expect(browser.getTitle()).toEqual('OpposingViews');
  });
});
