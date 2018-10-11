# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  
  scenario 'login and logout with password' do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'Logout'
    expect(page).to have_content 'Log in'
  end

  scenario 'login and logout with Twitter' do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = twitter_mock

    visit root_path
    click_link 'Sign in with Twitter'
    click_link 'Logout'
    expect(page).to have_content 'Log in'
  end
end