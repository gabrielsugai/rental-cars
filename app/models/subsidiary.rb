class Subsidiary < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :name,:cnpj, uniqueness: true
  validates :cnpj, format: { with: /\A^\d{2,3}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$\z/ }
  validate :cnpj_must_be_valid

  private

  def cnpj_must_be_valid
    unless CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'não é válido')
    end
  end
end
