class ProductsController < ApplicationController
  before_action :find_category, :only => [:index]
  before_action :find_product, :only => [:show]

  def index
    if @category.parent_id.nil?
      @parent_category = @category
      @child_categories = @parent_category.child_categories
      @products = Product.where("category_id in (?)", @child_categories.map(&:id)).distinct
    else
      @parent_category = @category.parent_category
      @child_categories = @parent_category.child_categories
      @products = @category.products
    end

    page = params[:page] || 1
    per = 15
    @products = @products.page(page).per(per)
  end

  def show
    @product_images = @product.product_images
    respond_to do |format|
      format.js
    end
  end

  private
    def find_category
      @category = Category.includes(:products).find_by_permalink(params[:permalink])
      if @category.nil?
        flash[:error] = "Cannot find the category"
        redirect_to root_path
      end
    end

    def find_product
      @product = Product.find_by_permalink(params[:permalink])
      if @product.nil?
        flash[:error] = "Cannot find the Product"
        redirect_to root_path
      end
    end
end
