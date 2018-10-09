# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'hoge@hoge.com' }
    password { 'passpass' }
  end
end
