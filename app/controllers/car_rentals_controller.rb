class CarRentalsController < ApplicationController
  def new
    @rental = Rental.find(params[:rental_id])
    @car_rental = CarRental.new

    @cars = @rental.car_category.cars #mesmo que a linha de baixo,possivel pelo through no model car_category, through diz que car category tem muitos carros atraves de car_model
    #@cars = Car.where(car_model: {car_category: @rental.car_category}
  end

  def create
    @rental = Rental.find(params[:rental_id])
    @car_rental = CarRental.new(params.require(:car_rental).permit(:car_id))
    @car_rental.user = current_user
    @car_rental.rental = @rental
    @car_rental.save
    @rental.ongoing!
    redirect_to @rental
  end
end