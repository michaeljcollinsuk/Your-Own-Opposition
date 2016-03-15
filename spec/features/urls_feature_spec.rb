require 'rails_helper'

feature 'Adding URLs' do

  before do
    signup
  end

  scenario '-> no URLs should be displayed yet' do
    expect(page).to_not have_content('www')
    expect(page).to have_content('Add link')
  end

  scenario 'display users urls' do
    Url.create(name: 'Guardian', link: 'www.guardian.com')
    visit '/'
    expect(page).to have_content('www.guardian.com')
  end

  scenario 'User can add a url' do
    visit '/'
    fill_in 'Name', with: 'Guardian'
    fill_in 'Link', with: 'www.firstlink.com'
    click_button 'Create Url'
    expect(page).to have_content('www.firstlink.com')
  end
end
