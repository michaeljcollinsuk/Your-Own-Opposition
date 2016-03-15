require 'rails_helper'

feature 'Adding URLs' do

  context '-> signed up ->' do

    before do
      signup
    end

    scenario '-> no URLs should be displayed yet' do
      expect(page).to_not have_content('www')
      expect(page).to have_content('Add link')
    end

    scenario '-> display users\' urls' do
      visit '/'
      create_url
      expect(page).to have_content('www.firstlink.com')
    end

    scenario '-> users are forced to provide a name/link when entering urls' do
      visit('/')
      expect{click_button('Create Url')}.not_to change(User, :count)
    end

    scenario '-> user can add a url' do
      visit '/'
      create_url
      expect(page).to have_content('www.firstlink.com')
    end

    scenario '-> only logged in users can see urls' do
      create_url
      click_link 'Sign out'
      expect(page).not_to have_content('www.firstlink.com')
    end

    scenario '-> users can only see their own urls' do
      create_url
      click_link 'Sign out'
      signup2
      expect(page).not_to have_content('www.firstlink.com')
    end

  end

  context '-> user not logged in ->' do

    scenario '-> users can\'t add urls' do
      visit('/')
      expect(page).not_to have_content('Add link')
      expect(page).to have_content("Sign up to get involved")
    end

  end

end
