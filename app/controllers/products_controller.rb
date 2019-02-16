class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[edit update toggle_state accept_offer destroy]

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
  end

  def update
    if @product.allowed_to_update? && @product.update(product_attributes)
      redirect_to products_path, format: 'js'
    else
      render 'update'
    end
  end

  def toggle_state
    @product.toggle_state

    redirect_to products_path
  end

  def accept_offer
    @product.accept_offer

    redirect_to products_path
  end

  def destroy
    @product.allowed_to_update? && @product.destroy

    redirect_to products_path, format: 'js'
  end

  private

  def product_attributes
    params.require(:product).permit(:name, :description, :price)
  end

  def find_product
    @product = current_user.products.find(params[:id])
  end
end
