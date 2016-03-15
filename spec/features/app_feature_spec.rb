require 'rails_helper'

feature 'Adding URLs' do

  before do
    signup
  end

  scenario '-> no URLs should be displayed yet' do
    expect(page).to_not have_content('www')
    expect(page).to have_content('Add link')
  end
end 
