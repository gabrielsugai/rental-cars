class CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end

  def search
    #nome exato @customers = Customer.where(name: params[:q])
    @customers = Customer.search(params[:q])
    render :index
  end

end