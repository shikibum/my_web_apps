require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe '#index' do
    context '@booksが返ってくる' do
      let(:book) { Book.create(title: 'Don quijote', memo: 'ドン・キホーテ', author: 'Cervantes') }
      let(:user) { User.create(email: 'hoge@hoge.com', password: 'passpass') }
      it '' do
        login_user(user)
        get :index
        binding.pry
        # expect(response).to 
      end
    end
  end
end

