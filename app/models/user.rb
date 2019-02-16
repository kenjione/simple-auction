# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :bids,     dependent: :destroy
end
