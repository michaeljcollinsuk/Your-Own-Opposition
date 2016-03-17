class AnalysisController < ApplicationController

  def index
    data = []
    urls = current_user.urls.all
    urls.each {|url| data << url.link}
    analysis = UrlAnalysis.new(data)
    render json: analysis
  end
end
