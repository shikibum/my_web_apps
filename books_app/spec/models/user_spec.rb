require 'rails_helper'

RSpec.describe User do
  describe '#password_required?' do
    context "password認証の場合" do
      it 'trueが返る' do
        user = User.create(email: 'hoge@hoge.com', password: 'passpass')
        expect(user.password_required?).to eq true
      end
    end

    context "twitter認証の場合" do
      it 'falseが返る' do
        user = User.create(email: 'hoge@hoge.com', provider: 'twitter', uid: '1013638572186800129')
        expect(user.password_required?).to eq false
      end
    end 
  end
end