require 'rails_helper'

feature 'Adding URLs' do

  before do
    signup
  end

  scenario '-> no URLs should be displayed yet' do
    expect(page).to_not have_content('www')
    expect(page).to have_content('Add link')
  end

  scenario 'User can add a url' do
    fill_in 'url', with: 'www.firstlink.com'
    click_button 'Add'
    expect(page).to have_content('www.firstlink.com')
  end
end
