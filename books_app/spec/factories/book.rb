# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Test Book' }
    memo { 'Test Memo' }
    author { 'Test Author' }
  end
end
