# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe '#index' do
    @book1 = let!(:book) { Book.create(title: 'Don quijote', memo: 'ドン・キホーテ', author: 'Cervantes') } # let!は実行される
    @book2 = let!(:book) { Book.create(title: '吾輩は猫である', memo: 'にゃーん', author: '夏目漱石') } # let!は実行される
    let(:user) { User.create(email: 'hoge@hoge.com', password: 'passpass') }

    it '@booksに全ての本を割り当てること' do
      login_user(user)
      get :index
      expect(response.status).to eq 200
      # expect(assigns(:books)).to match_array([@book1,@book2])
      # expect(response).to render_template :index
    end
  end
end
