# frozen_string_literal: true

FactoryBot.define do
  factory :bid do
    user
    product
    amount { 100 }
  end
end
