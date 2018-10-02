# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books', type: :feature do
  scenario 'user creates a new book' do
    user = FactoryBot.create(:user)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect{
      click_link '本を追加'
      fill_in 'タイトル',	with: 'Test Book'
      fill_in 'メモ',	with: 'Test Memo'
      fill_in '著者',	with: 'Test Author'
      click_button '登録する'

      expect(page).to have_content 'Book was successfully created'
      expect(page).to have_content 'Test Book'
    }.to change(Book, :count).by(1)
  end
end