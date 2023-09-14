class Admin::ProductsController < Admin::ApplicationController
  before_action :find_product, :only => [:show, :destroy, :edit, :update]

  def index
    @products = Product.order("created_at DESC").page(params[:page]).per(25)
    @no = params[:page].to_i * 25
  end

  def new
    @product = Product.new
    @product.product_images.build
    @categories = Category.category_list
    @shapes = Product::SHAPE
    @product_category = []
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product successfully created"
      redirect_to admin_products_path
    else
      @categories = Category.category_list
      @shapes = Product::SHAPE
      @product_category = params[:product][:category_id].map(&:to_i)
      flash[:error] = "Product failed to create"
      render :action => "new"
    end
  end

  def show
    @product_image = ProductImage.new
    @product_images = @product.product_images
  end

  def edit
    # @product_category = @product.categories.map(&:id)
    if @product.product_images.blank?
      @product.product_images.build
    end
    @categories = Category.category_list
    @shapes = Product::SHAPE
  end

  def update
    if @product.update_attributes(product_params)
      flash[:notice] = "Product successfully updated"
      redirect_to admin_products_path
    else
      @categories = Category.category_list
      @shapes = Product::SHAPE
      flash[:error] = "Product failed to update"
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] =  @product.destroy ? 'Product was successfully deleted.' :
                                      'Product was falied to delete.'
    redirect_to admin_products_path
  end

  private

    def product_params
      params.require(:product).permit(:name, :category_id, :shape,
                                      product_images_attributes: [:id, :image, :_destroy])
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.nil?
        flash[:error] = "Cannot find the Product with id '#{params[:id]}'"
        redirect_to admin_products_path
      end
    end
end
