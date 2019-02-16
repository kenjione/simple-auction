# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :filtered

  def index; end

  private

  def filtered
    return @products = Product.won_by(current_user).decorate if params[:filter] == 'won'

    @products = Product.available_for_auction(current_user).ordered
    @products = @products.bid_by(current_user) if params[:filter] == 'my_bids'
    @products = @products.decorate
  end
end
