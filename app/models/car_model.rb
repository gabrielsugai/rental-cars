class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category
  validates :name, :year, :motorization, :fuel_type, :manufacturer, :car_category, presence: true
end
