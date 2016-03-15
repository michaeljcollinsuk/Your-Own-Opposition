class UrlsController < ApplicationController

  def index
    @url = Url.all
  end

  def create
    @url = Url.create(url_params)
    redirect_to '/'
  end

  def url_params
    params.require(:url).permit(:name, :link)
  end

end
