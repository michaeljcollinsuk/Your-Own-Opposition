require 'rails_helper'

describe SuggestionsController, type: :controller do
  include Devise::TestHelpers
  include AnalysisHelper

  xdescribe "GET suggestions" do
    it "returns a suggestion" do
    #
    # user = create(:user)
    # sign_in user
    # url = create(:url)
    get :index
    json = JSON.parse(response.body)
    expect(json["recommend_reading"]).to eq({"dailymail"=>2, "telegraph"=>3, "bbc"=>40, "thesun"=>2, "thetimes"=>4, "express"=>10})
    end
  end
end
