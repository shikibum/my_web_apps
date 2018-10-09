# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = twitter_mock
  end

  scenario 'sign up new user with Twitter, and edit profile without password' do
    visit new_user_registration_path
    expect do
      click_link 'Sign in with Twitter'
    end.to change(User, :count).by(1)

    click_link 'Edit profile'
    fill_in 'Email', with: 'kawauso@hoge.com'
    click_button 'Update'
    expect(page).to have_content 'Logged in as kawauso'
  end
end
