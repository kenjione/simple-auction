class BidsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
  end

  def create
    @bid = Bid.new(bid_params)

    if @bid.save
      redirect_to root_path, format: 'js'
    else
      render 'create'
    end
  end

  private

  def bid_params
    params.require(:bid)
          .permit(:amount)
          .merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
