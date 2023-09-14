class Admin::CategoriesController < Admin::ApplicationController
  before_action :find_category, :only => [:destroy, :edit, :update]

  def index
    @categories = Category.child_categories.order("created_at DESC").page(params[:page]).per(20)
    @no = paging(20)
  end

  def new
    @category = Category.new
    @parent_categories = Category.parent_categories
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully created"
      redirect_to admin_categories_path
    else
      puts @category
      flash[:error] = "Category failed to create"
      render :action => "new"
    end
  end

  def edit; end

  def update
    if @category.update_attributes(category_params)
      flash[:notice] = "Category successfully updated"
      redirect_to admin_categories_path
    else
      flash[:error] = "Category failed to update"
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] =  @category.destroy ? 'Category was successfully deleted.' :
                                      'Category was falied to delete.'
    redirect_to admin_categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :parent_id)
    end

    def find_category
      @category = Category.find_by_id(params[:id])
      if @category.nil?
        flash[:error] = "Cannot find the Category with id '#{params[:id]}'"
        redirect_to admin_categories_path
      end
    end
end
