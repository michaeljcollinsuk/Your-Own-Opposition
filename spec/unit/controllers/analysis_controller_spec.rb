require 'rails_helper'

describe AnalysisController, type: :controller do
 describe "GET analysis" do
   it "returns the analysis of the url" do

     user = FactoryGirl.create(:user, password: 'password', email: 'bob@bob.com', password_confirmation: 'password')
     FactoryGirl.create(:url, link: 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs', user: user)
     sign_in user
     get :index
     json = JSON.parse(response.body)
    #  expected = {"current_bias": -100}
     expect(json.keys).to contain_exactly("current_bias", "funny_bias_message", "media_diet", "papers", "top_topics", "url_parser")
   end
 end
end
