# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#password_required?' do
    context 'password認証の場合' do
      it 'trueが返る' do
        user = User.create(email: 'hoge@hoge.com', password: 'passpass')
        expect(user.password_required?).to eq true
      end
    end

    context 'twitter認証の場合' do
      it 'falseが返る' do
        user = User.create(email: 'hoge@hoge.com', provider: 'twitter', uid: '1013638572186800129')
        expect(user.password_required?).to eq false
      end
    end
  end

  describe 'update_with_password' do
    context 'Twitter_userの場合' do
      it 'パスワードなしで更新できる' do
        user = User.create(email: 'hoge@hoge.com', provider: 'twitter', uid: '1013638572186800129')
        expect(user.update_with_password(name: 'shikibu')).to eq true
        user.reload
        expect(user.name).to eq 'shikibu'
      end
    end

    context 'Twitter_userでない場合' do
      it 'パスワードなしだと更新できない' do
        user = User.create(email: 'hoge@hoge.com', password: 'passpass')
        expect(user.update_with_password(name: 'shikibu')).to eq false
      end

      it 'パスワードありだと更新できる' do
        user = User.create(email: 'hoge@hoge.com', password: 'passpass')
        expect(user.update_with_password(name: 'shikibu', current_password: 'passpass')).to eq true
      end
    end
  end
end
