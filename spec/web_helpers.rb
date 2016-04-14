

def signup(email='bob@bob.com', password='password')
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  fill_in('Password confirmation', with: password)
  click_button 'Sign up'
end

def login(email='bob@bob.com', password='password')
  visit('/')
  click_link 'Sign in'
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  click_button ('Sign in')
end

def create_url(link='www.firstlink.com')
  fill_in 'Link', with: link
  click_button 'Create Url'
end
