class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
      .includes(:bid)
      .by_user(current_user)
      .filtered(params[:filter]).decorate
  end

  def create
    @product = current_user.products.build(product_attributes)

    if @product.save
      redirect_to products_path, format: 'js'
    else
      render 'create'
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])

    if @product.update(product_attributes)
      redirect_to products_path, format: 'js'
    else
      render 'update'
    end
  end

  def toggle_state
    @product = current_user.products.find(params[:id])
    @product.toggle_state

    redirect_to products_path
  end

  def accept_offer
    @product = current_user.products.find(params[:id])
    @product.accept_offer

    redirect_to products_path
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy

    redirect_to products_path, format: 'js'
  end

  private

  def product_attributes
    params.require(:product).permit(:name, :description, :price)
  end
end
