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
      redirect_to @host
    else
      render 'new'
    end
  end
end
