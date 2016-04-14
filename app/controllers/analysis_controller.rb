class AnalysisController < ApplicationController
  include AnalysisHelper

  def index
    analysis = UrlAnalysis.new(retrieve_urls)
    save_to_user(analysis)
    render json: analysis
  end
end
