# frozen_string_literal: true

require 'rails_helper'
Rspec.feature 'books_index_spec', type: :feature do
  describe 'index ' do
    user = User.create(email: 'hoge@hoge.com', provider: 'twitter', uid: '1013638572186800129')
    specify 'Booksを表示' do
      visit root_path
      expect(page).to have_content 'Books'
    end
  end
end
