require 'rails_helper'

feature 'suggestions' do

  before do
    signup
    create_url2
  end

  scenario 'it responds with a suggestion' do
    visit '/suggestions'
    expect(page).to have_content 'dailymail'
  end

  # scenario 'it responds with a suggestion' do
  #   visit '/suggestions'
  #   expect(page).to have_content 'dailymail'
  # end
end
