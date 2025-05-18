class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
    Rails.logger.info "Loaded all products, total count: #{@products.size}"
  end

  def show
    Rails.logger.info "Showing product with ID: #{@product.id}"
  end

  def new
    @product = Product.new
    Rails.logger.info "Initialized new product"
  end

  def edit
    Rails.logger.info "Editing product with ID: #{@product.id}"
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      Rails.logger.info "Created product with ID: #{@product.id}"
      redirect_to @product, notice: "Product was successfully created."
    else
      Rails.logger.warn "Failed to create product: #{@product.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @product.update(product_params)
      Rails.logger.info "Updated product with ID: #{@product.id}"
      redirect_to @product, notice: "Product was successfully updated."
    else
      Rails.logger.warn "Failed to update product ID #{@product.id}: #{@product.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @product.destroy!
    Rails.logger.info "Destroyed product with ID: #{@product.id}"
    redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed."
  end

  private

  def set_product
    @product = Product.find(params[:id])
    Rails.logger.debug "Set @product with ID: #{@product.id}"
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "Product not found with ID: #{params[:id]} - #{e.message}"
    redirect_to products_path, alert: "Product not found."
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
