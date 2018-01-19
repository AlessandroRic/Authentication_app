require 'rails_helper'
require 'session_helper'

feature 'User Account' do
  include SessionHelper
  let(:user) { FactoryGirl.create(:user) }

  scenario 'a new user signs up' do
    sign_up
    expect(page).to have_content('User created successfully')
    save_and_open_page
  end

  scenario 'restered user logs in' do
    log_in
    expect(page).to have_content("You're now logged in")
    expect(current_path).to eq user_path(user)
    within 'h1' do
      expect(page).to have_content(user.first_name + ' ' + user.last_name)
    end
  end

  scenario 'user logs out' do
    log_in
    click_link 'Account'
    click_link 'Log Out'
    expect(current_path).to eq root_path
    expect(page).to have_content('Bye, See you soon!')
  end
end