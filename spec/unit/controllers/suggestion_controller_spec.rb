require 'rails_helper'

describe SuggestionsController, type: :controller do
 describe "GET suggestions" do
   it "returns a suggestion" do

     user = FactoryGirl.create(:user, password: 'password', email: 'bob@bob.com', password_confirmation: 'password')
     FactoryGirl.create(:url, link: 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs', user: user)

    #  scenario = Scenario.create(title: "Running late")
    #  FactoryGirl.create(:excuse, title: "My dog ate my shoes", scenario: scenario)
    #  FactoryGirl.create(:excuse, title: "An alien warship blew up the bridge", scenario: scenario)
    #  FactoryGirl.create(:excuse, title: "I lost my only pair of trousers", scenario: scenario)
     sign_in user
     get :index, session: {current_user: user}
     json = JSON.parse(response.body)

     expect(json).to include "suggested_sources" => {"dailymail"=>2, "telegraph"=>3, "bbc"=>40, "sun"=>2, "thetimes"=>4, "dailyexpress"=>10}
   end
 end
end
