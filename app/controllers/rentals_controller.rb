class RentalsController < ApplicationController
  
  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
    @customers = Customer.all
    @car_categories = CarCategory.all 
  end
  
  def create
    @rental = Rental.new(rental_params)
    @rental.save
    redirect_to rentals_path
  end

  def search
    @q = params[:q]
    @rental = Rental.find_by(code: @q.upcase)
  end

  private
  
  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :customer_id, :car_category_id)
  end

end