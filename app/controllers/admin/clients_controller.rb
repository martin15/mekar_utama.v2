class Admin::ClientsController < Admin::ApplicationController
  before_action :find_client, :only => [:destroy, :edit, :update]

  def index
    @clients = Client.order("created_at DESC").page(params[:page]).per(10)
    @no = params[:page].to_i * 10
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:notice] = "Client successfully created"
      redirect_to admin_clients_path
    else
      flash[:error] = "Client failed to create"
      render :action => "new"
    end
  end

  def edit; end

  def update
    if @client.update_attributes(client_params)
      flash[:notice] = "Client successfully updated"
      redirect_to admin_clients_path
    else
      flash[:error] = "Client failed to update"
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] =  @client.destroy ? 'Client was successfully deleted.' :
                                      'Client was falied to delete.'
    redirect_to admin_clients_path
  end

  private
    def client_params
      params.require(:client).permit(:name, :best_client, :image)
    end

    def find_client
      @client = Client.find_by_id(params[:id])
      if @client.nil?
        flash[:error] = "Cannot find the Client with id '#{params[:id]}'"
        redirect_to admin_clients_path
      end
    end
end
