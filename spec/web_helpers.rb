def signup
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'bob@bob.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button 'Sign up'
end

def login
  visit('/')
  click_link 'Sign in'
  fill_in('Email', with: 'bob@bob.com')
  fill_in('Password', with: 'password')
  click_button ('Sign in')
end

def create_url
  fill_in 'Name', with: 'Guardian'
  fill_in 'Link', with: 'www.firstlink.com'
  click_button 'Create Url'
end

def signup2
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'dave@bob.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button 'Sign up'
end
