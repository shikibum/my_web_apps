require 'rails_helper'

describe "books/index" do
    before(:each) do
      @book1 = Book.create(title: 'Don quijote', memo: 'ドン・キホーテ', author: 'Cervantes')
      @book2 = Book.create(title: '吾輩は猫である', memo: 'にゃーん', author: '夏目漱石')
      # @books = [@book1, @book2]
      @books = Book.page(1).per(5).order('updated_at DESC')
    end

  it "display all the books" do
    assign(:books, @books)
    render template: 'books/index.html.erb'
    expect(rendered).to match /Don quijote/
    expect(rendered).to match /吾輩は猫である/
  end
end
