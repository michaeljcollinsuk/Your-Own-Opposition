class SuggestionsController < ApplicationController

  def index
    # tester = 'test'
    # render json: {one: "guardian"}
    data = []
    urls = current_user.urls.all
    urls.each { |url| data << url.link }
    suggestion = Suggestion.new(UrlAnalysis, data)
    suggestion.news_source
    render json: suggestion
  end
end
