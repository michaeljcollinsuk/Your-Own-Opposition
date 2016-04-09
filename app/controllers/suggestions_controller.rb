class SuggestionsController < ApplicationController

  def index
    current_analysis = current_user.analyses.last
    suggestion = Suggestion.new(current_analysis)
    suggestion.make_suggestion
    render json: suggestion
  end

end
