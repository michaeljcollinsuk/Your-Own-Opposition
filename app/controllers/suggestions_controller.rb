class SuggestionsController < ApplicationController

  def index
    data = []
    urls = current_user.urls.all
    urls.each { |url| data << url.link }
    suggestion = Suggestion.new(UrlAnalysis, data)
    suggestion.make_suggestion
    render json: suggestion
  end

end
