require 'rails_helper'

describe 'books/edit' do
    before(:each) do
      @book = Book.create(title: 'Don quijote', memo: 'ドン・キホーテ', author: 'Cervantes')
    end

  it 'renders the edit book form' do
    render template: 'books/edit.html.erb'
    assert_select 'input#book_title[value=?]', 'Don quijote'
    assert_select 'textarea#book_memo', 'ドン・キホーテ'
    assert_select 'input#book_author[value=?]', 'Cervantes'
  end
end