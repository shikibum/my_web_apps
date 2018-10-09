# frozen_string_literal: true

require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature 'Books', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'user creates a new book, show index, show, edit and destroy the book', js: true do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect do
      click_link '本を追加'
      fill_in 'タイトル',	with: 'Test Book'
      fill_in 'メモ',	with: 'Test Memo'
      fill_in '著者',	with: 'Test Author'
      click_button '登録する'

      expect(page).to have_content 'Book was successfully created'
      expect(page).to have_content 'Test Book'
    end.to change(Book, :count).by(1)

    visit root_path
    expect(page).to have_content 'Test Book'

    click_link 'Show'
    click_link 'Edit'
    fill_in 'タイトル',	with: 'てすとぶっく'
    click_button '更新する'
    expect(page).to have_content 'てすとぶっく'
    click_link 'Back'

    expect do
      click_link 'Destroy'
      driver = Selenium::WebDriver.for :chrome
      accept_alert do
        alert = begin
                  driver.switch_to.alert.accept
                rescue StandardError
                  Selenium::WebDriver::Error::NoAlertOpenError
                end
      end
    end.to change(Book, :count).by(0)
  end
end
