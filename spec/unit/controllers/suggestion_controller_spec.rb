require 'rails_helper'

describe SuggestionsController, type: :controller do
 describe "GET suggestions" do
   it "returns a suggestion" do

     user = FactoryGirl.create(:user, password: 'password', email: 'bob@bob.com')
     FactoryGirl.create(:url, link: 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs', user: user)
     sign_in user
     get :index
     json = JSON.parse(response.body)
     expect(json["suggested_sources"]).to eq({"dailymail"=>2, "telegraph"=>3, "bbc"=>40, "thesun"=>2, "thetimes"=>4, "express"=>10})
   end
 end
end
