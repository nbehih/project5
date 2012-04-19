class HostsController < ApplicationController
  def new
    @host = Host.new
    @title = "Sign up"
  end
  
  def show
    @host = Host.find(params[:id])
  end
end
