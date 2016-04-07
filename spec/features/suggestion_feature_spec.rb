require 'rails_helper'

feature 'suggestions' do

  before do
    signup
    create_url('http://www.theguardian.com/politics/blog/live/2016/mar/17/budget-2016-george-osborne-today-interview-politics-live.com')
  end

  scenario 'it responds with a suggestion' do
    visit '/suggestions'
    expect(page).to have_content 'dailymail'
  end

  #MORE TESTS NEEDED HERE PLEASE!
end
