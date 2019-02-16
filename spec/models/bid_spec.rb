# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid, type: :model do
  let(:user) { create :user, :rich }
  let(:product) { create :product }
  let(:bid) do
    build :bid, user: user, product: product, amount: 1000
  end

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:product) }

  it 'Bid valid' do
    expect(bid).to be_valid
  end
end
