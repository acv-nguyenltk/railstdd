class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
    render :new
  end

  def update
    return redirect_to products_url, notice: 'Updated' if @product.update(product_params)
      flash.now[:notice] = "Not yet"
    render :new
  end

  def create
    @product = Product.create(product_params)
    return redirect_to products_url, notice: 'Created' if @product.save
      flash.now[:notice] = 'Not yet'
    render :newx
  end

  def destroy
    return redirect_to products_url, notice: 'Deleted' if @product.destroy
    flash.now[:notice] = 'Not yet'
    redirect_to products_url
  end

  private def product_params
    params.require(:product).permit(:title, :description, :price, :published,
            :category_id)
  end

  private def get_product
    @product = Product.find(params[:id])
  end
end
