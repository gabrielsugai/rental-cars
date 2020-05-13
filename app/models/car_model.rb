class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars
  validates :name, :year, :motorization, :fuel_type, :manufacturer, :car_category, presence: true
end
