class Customer < ApplicationRecord
  has_many :rentals
  
  scope :search, ->(query) { where('name LIKE ?', "%#{query}%").or(where(cpf: query))}
  # def self.search(query)
  #   where('name LIKE ?', "%#{query}%")
  # end
  
end
