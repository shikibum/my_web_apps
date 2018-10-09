# frozen_string_literal: true

# # frozen_string_literal: true

require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature 'Users', type: :feature do
  scenario 'sign up new user, edit, logout, login, and destroy', js: true do
    visit new_user_registration_path
    expect do
      fill_in 'Email', with: 'hoge@hoge.com'
      fill_in 'Password', with: 'passpass'
      fill_in 'Password confirmation', with: 'passpass'
      click_button 'Sign up'
    end.to change(User, :count).by(1)

    click_link 'Logout'

    fill_in 'Email', with: 'hoge@hoge.com'
    fill_in 'Password', with: 'passpass'
    click_button 'Log in'

    click_link 'Edit profile'
    fill_in 'Email', with: 'kawauso@hoge.com'
    fill_in 'Current password', with: 'passpass'
    click_button 'Update'
    expect(page).to have_content 'Logged in as kawauso'

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
end
