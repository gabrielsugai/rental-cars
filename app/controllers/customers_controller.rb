class CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end

  def search
    #nome exato @customers = Customer.where(name: params[:q])
    @customers = Customer.search(params[:q])
    render :index
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params.require(:customer).permit(:name, :cpf, :email))
    @customer.save
    redirect_to customers_path
  end

end

# TODO: Validar dados do cliente