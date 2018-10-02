# # frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'sign up new user' do
    visit new_user_registration_path
    # visit root_path
    # within '.navbar-link' do
    #   click_link 'Sign up'
    # end
  
    expect{
      fill_in 'Email', with: 'hoge@hoge.com'
      fill_in 'Password', with: 'passpass'
      fill_in 'Password confirmation', with: 'passpass'
      click_button 'Sign up'
save_and_open_page
    }.to change(User, :count).by(1)
  end

  scenario 'sign up new user with Twitter' do
  end
end