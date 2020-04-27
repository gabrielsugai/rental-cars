class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(params.require(:car_model).permit(:name, :motorization, :year, :fuel_type, :manufacturer_id, 
                                                                :car_category_id))
    if @car_model.save
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      render :new
    end
  end

end