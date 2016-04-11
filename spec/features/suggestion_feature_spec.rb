require 'rails_helper'

feature 'suggestions' do

  before do
    signup
    create_url('http://www.theguardian.com/politics/blog/live/2016/mar/17/budget-2016-george-osborne-today-interview-politics-live.com')
    visit '/analysis'
  end

  scenario 'it responds with a suggestion in json' do
    visit '/suggestions'
    expect(page).to have_content 'dailymail'
  end

  #MICHAEL MORE TESTS NEEDED HERE PLEASE!
end
