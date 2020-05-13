class CarCategoriesController < ApplicationController
  
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_categories = CarCategory.find(params[:id])
    #@car_models = CarModel.where(car_category: @car_categories)
  end

  def new
    @car_categories = CarCategory.new
  end

  def create
    @car_categories = CarCategory.new(car_categories_params)
    @car_categories.save
    redirect_to @car_categories
  end

  private

  def car_categories_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end

#TODO: Editar categorias
#TODO: Criar model Car
#TODO: Validar valores de car category