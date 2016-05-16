require 'rails_helper'

feature 'registration', %q{
  In order to sign in
  As user
  I want to be able registration
} do

  given(:user){ build :user }

  scenario 'registration' do
    registration(user)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end
end