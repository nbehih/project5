class HostsController < ApplicationController
  def new
    @host = Host.new
    @title = "Sign up"
  end
  
  def show
    @host = Host.find(params[:id])
    @title = @host.first_name
  end
    def new
    @host = Host.new
  end
    def create
    @host = Host.new(params[:host])
    if @host.save
      flash[:success] = "welcome to the new Page"
      redirect_to @host
    else
      @title ="Sign up!"
      render 'new'
    end
  end
end
