# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]
  has_one_attached :avatar

  class << self
    # def self.from_omniauth(auth)
    #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    def find_or_create_for_oauth(auth)
      find_or_create_by!(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email
        user.name = auth.info.name # assuming the user model has a name
        user.image_url = auth.info.image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank? # provider属性に値があればパスワード入力免除
  end

  # Edit時、OmniAuthで認証したユーザーのパスワード入力免除するため、Deviseの実装をOverrideする。
  def update_with_password(params, *options)
    if encrypted_password.blank?            # encrypted_password属性が空の場合
      update_attributes(params, *options)   # パスワード入力なしにデータ更新
    else
      super
    end
  end
end
