class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiaries = Subsidiary.find(params[:id])
  end

  def new
    @subsidiaries = Subsidiary.new
  end

  def create
    @subsidiaries = Subsidiary.new(subsidiaries_params)
    @subsidiaries.save
    redirect_to @subsidiaries
  end

  private  
  def subsidiaries_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end
end

#TODO: edit filial