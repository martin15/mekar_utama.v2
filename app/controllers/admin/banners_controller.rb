class Admin::BannersController < Admin::ApplicationController
  before_action :find_banner, :only => [:destroy, :edit, :update]

  def index
    @banners = Banner.order("created_at DESC").page(params[:page]).per(5)
    @no = params[:page].to_i * 5
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      flash[:notice] = "Banner successfully created"
      redirect_to admin_banners_path
    else
      flash[:error] = "Banner failed to create"
      render :action => "new"
    end
  end

  def edit; end

  def update
    if @banner.update_attributes(banner_params)
      flash[:notice] = "Banner successfully updated"
      redirect_to admin_banners_path
    else
      flash[:error] = "Banner failed to update"
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] =  @banner.destroy ? 'Banner was successfully deleted.' :
                                      'Banner was falied to delete.'
    redirect_to admin_banners_path
  end

  private

    def banner_params
      params.require(:banner).permit(:image, :url, :alt, :b_type )
    end

    def find_banner
      @banner = Banner.find_by_id(params[:id])
      if @banner.nil?
        flash[:error] = "Cannot find the Banner with id '#{params[:id]}'"
        redirect_to admin_banners_path
      end
    end
end
