# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :product, presence: true
  validates :user, presence: true

  validate :overbid, on: :create
  validate :insufficient_funds, on: :create

  before_create :destroy_previous_bid
  after_create :charge
  after_create :mark_product
  after_destroy :refund

  delegate :email, to: :user, prefix: true

  private

  # callbacks

  def destroy_previous_bid
    return unless bid = product.reload.bid
    bid.destroy
  end

  def charge
    user.with_lock do
      user.update_attribute :balance, user.balance - amount
    end
  end

  def mark_product
    product.update_attribute(:state, 'under_offer')
  end

  def refund
    user.with_lock do
      user.update_attribute :balance, user.balance + amount
    end
  end

  # validations

  def overbid
    return unless product
    return unless (product.reload.bid_amount && amount <= product.bid_amount.to_f) || amount < product.price
    errors.add(:amount, 'should be equal or higher than current bid')
  end

  def insufficient_funds
    return unless user && amount > user.balance
    errors.add(:user, 'Has insufficient balance')
  end
end
