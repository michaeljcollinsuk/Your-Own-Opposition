require 'rails_helper'

feature 'suggestions' do

  # before do
  #   current_user = FactoryGirl.create(:user, password: 'password', email: 'bob@bob.com')
  #   FactoryGirl.create(:url, link: 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs', user: current_user)
  # end

  before do
    signup
    create_url2
  end 

  scenario 'it responds with a suggestion' do
    visit '/suggestions'
    expect(page).to have_content 'dailymail'
  end
end
