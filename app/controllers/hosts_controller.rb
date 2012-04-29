class HostsController < ApplicationController
  
  
  def new
    @host = Host.new
    @title = "Sign up"
  end
  
  def show
    @host = Host.find(params[:id])
    @title = @host.first_name
  end

    def create
    @host = Host.new(params[:host])
    if @host.save
      sign_in @host
      flash[:success] = "welcome to the new Page"
      redirect_to @host
    else
      @title ="Sign up!"
      render 'new'
    end
  end
  
  def index
      @title = "All hosts"
      @hosts = Host.all
    end
    private
    def authenticate
          deny_access unless signed_in?
    end

    def correct_host
          @host = Host.find(params[:id])
          redirect_to(root_path) unless current_host?(@host)
    end
    def admin_host
          redirect_to(root_path) unless current_host.admin?
        end
  
    

end
  