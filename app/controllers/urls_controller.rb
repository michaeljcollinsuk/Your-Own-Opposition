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

end
