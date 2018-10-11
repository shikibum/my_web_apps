# frozen_string_literal: true

require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature 'Users', type: :feature do
  scenario 'sign up new user with password and destroy', js: true do
    visit new_user_registration_path
    expect do
      fill_in 'Email', with: 'hoge@hoge.com'
      fill_in 'Password', with: 'passpass'
      fill_in 'Password confirmation', with: 'passpass'
      click_button 'Sign up'
    end.to change(User, :count).by(1)

    expect do
      click_link 'Edit profile'
      click_button 'Cancel my account'
      driver = Selenium::WebDriver.for :chrome
      accept_alert do
        alert = begin
                  driver.switch_to.alert.accept
                rescue StandardError
                  Selenium::WebDriver::Error::NoAlertOpenError
                end
      end
    end.to change(User, :count).by(0)
    expect(page).to have_content 'Log in'
  end

  scenario 'edit profile with password' do
    user = FactoryBot.create(:user)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Edit profile'
    fill_in 'Email', with: 'kawauso@hoge.com'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content 'Logged in as kawauso'
  end  
end

RSpec.feature 'Users', type: :feature do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = twitter_mock
  end

  scenario 'sign up new user with Twitter, and destroy ', js: true do
    visit new_user_registration_path
    expect do
      click_link 'Sign in with Twitter'
      sleep 0.5
    end.to change(User, :count).by(1)

    expect do
      click_link 'Edit profile'
      click_button 'Cancel my account'
      driver = Selenium::WebDriver.for :chrome
      accept_alert do
        alert = begin
                  driver.switch_to.alert.accept
                rescue StandardError
                  Selenium::WebDriver::Error::NoAlertOpenError
                end
      end
    end.to change(User, :count).by(0)
    expect(page).to have_content 'Log in'
  end

  scenario 'Twitter user edits profile without password' do
    visit root_path
    click_link 'Sign in with Twitter'
    click_link 'Edit profile'
    fill_in 'Email', with: 'kawauso@hoge.com'
    click_button 'Update'
    expect(page).to have_content 'Logged in as kawauso'
  end
end