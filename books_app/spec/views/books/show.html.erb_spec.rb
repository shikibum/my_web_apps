# frozen_string_literal: true

require 'rails_helper'

describe 'books/show' do
  before(:each) do
    @book = Book.create(title: 'Don quijote', memo: 'ドン・キホーテ', author: 'Cervantes')
  end

  it 'redering with the show template' do
    assign(:book, @book)
    render template: 'books/show.html.erb'
    expect(rendered).to match(/Don quijote/)
  end
end
