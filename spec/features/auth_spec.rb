require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    expect(current_path).to eq("/users/new")
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')

  end


  feature 'signing up a user' do
    # person = User.create(username: 'jon', password_digest: '123456', session_token: 'adf')
    
    scenario 'shows username on the homepage after signup' do
      sign_up_with("jon", "123456")
      expect(page).to have_content('jon')
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
  end

end