# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    user
    name { FFaker::Product.product_name }
    description { FFaker::Book.description }
    price { 100 }
  end
end
