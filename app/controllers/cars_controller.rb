class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def new
    @cars = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @cars = Car.new(params.require(:car).permit(:license_plate, :color, :car_model_id, :milage, :subsidiary_id))
    @cars.save
    redirect_to cars_path
  end
  # TODO: validates Placa deve ser unica, km >=0, todos os campos obrigatorios
end