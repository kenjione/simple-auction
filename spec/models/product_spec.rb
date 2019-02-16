# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create :user, :rich }
  let(:product) { create :product, user: user }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:price) }

  it 'Product valid' do
    expect(product).to be_valid
  end

  it 'Accepts offer' do
    bid = create :bid, product: product

    expect { product.accept_offer }.to\
      change { product.reload.state }.to('sold').and\
      change { bid.reload.state }.to('accepted').and\
      change { user.reload.balance }.by(bid.amount)
  end

  it 'Changes state' do
    expect { product.toggle_state }.to\
      change { product.reload.state }.from('hidden').to('published')

    expect { product.toggle_state }.to\
      change { product.reload.state }.from('published').to('hidden')
  end
end
