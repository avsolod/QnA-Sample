require 'rails_helper'

feature 'login', %q{
  In order to be
  As an user
  I want to be able log in log out
} do

  given(:user) { create :user }

  scenario 'registered user' do
    visit questions_path
    expect(page).to have_content 'Login'

    login(user)
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Logout'

    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content 'Login'
  end
end
