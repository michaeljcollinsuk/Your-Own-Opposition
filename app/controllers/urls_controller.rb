class UrlsController < ApplicationController

  def index
    @url = Url.all
  end

  def create
    @url = current_user.urls.new(url_params)
    @url.save
    redirect_to '/'
  end

  def url_params
    params.require(:url).permit(:name, :link)
  end

  def show
    # urls = Url.all
    # data = []
    # urls.each { |url| data << url.link }
    # @response = {source: data[0], tag: data[1], bias: -80}
    # render json: @response
    render json: {source: 'Guardian'}
  end

end
