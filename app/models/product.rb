# frozen_string_literal: true

class Product < ApplicationRecord
  extend Enumerize

  belongs_to :user

  has_one :bid, dependent: :destroy, validate: true

  validates_associated :bid
  validates :user, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available_for_auction, ->(user) { includes(:bid).where.not(user_id: user, state: %i[hidden sold]) }
  scope :by_user, ->(user) { where(user_id: user) }
  scope :bid_by, ->(user) { includes(:bid).where(bids: { user_id: user }) }
  scope :won_by, ->(user) { includes(:bid).where(bids: { user_id: user, state: :accepted }) }
  scope :ordered, ->{ order(updated_at: :desc) }

  enumerize :state, in: %i[hidden published under_offer sold]

  delegate :amount, to: :bid, prefix: true, allow_nil: :true
  delegate :user, to: :bid, prefix: true, allow_nil: :true

  def self.filtered(filter)
    return all unless Product.state.values.include?(filter)
    where(state: filter)
  end

  def toggle_state
    case state
    when 'hidden' then update_attribute(:state, :published)
    when 'published' then update_attribute(:state, :hidden)
    else nil
    end
  end

  def accept_offer
    user.with_lock do
      user.update_attribute :balance, user.balance + bid_amount
      bid.update_attribute :state, :accepted
      update_attribute(:state, 'sold')
    end
  end

  def allowed_to_update?
    %w[published hidden].exclude?(state)
  end
end
