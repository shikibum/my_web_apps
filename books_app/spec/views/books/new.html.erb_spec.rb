# frozen_string_literal: true

require 'rails_helper'

describe 'books/new' do
  before(:each) do
    assign(:book, Book.new)
  end

  it 'renders new book form' do
    render template: 'books/new.html.erb'
    assert_select 'form[action=?][method=?]', books_path, 'post' do
      assert_select 'input#book_title[name=?]', 'book[title]'
      assert_select 'textarea#book_memo[name=?]', 'book[memo]'
      assert_select 'input#book_author[name=?]', 'book[author]'
    end
  end
end
