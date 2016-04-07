class SuggestionsController < ApplicationController

#THIS METHOD IS EXACTLY THE SAME AS THE ONE IN THE ANALYSIS CONTROLLER.
# USE A HELPER METHOD FOR THIS
  def index
    data = []
    urls = current_user.urls.all
    urls.each { |url| data << url.link }
    suggestion = Suggestion.new(data)
    suggestion.make_suggestion
    render json: suggestion
  end

end
