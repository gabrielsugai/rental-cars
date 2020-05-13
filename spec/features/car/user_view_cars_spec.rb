require 'rails_helper'

feature 'User can view all cars' do
  scenario 'Successfully' do
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    subs = Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')
    cm = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, 
                          motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)
    car_a = Car.create!(license_plate: 'ABC1234', color: 'Preto', milage: 0, car_model: cm, subsidiary: subs)
    car_b = Car.create!(license_plate: 'ABC4321', color: 'Branco', milage: 0, car_model: cm, subsidiary: subs)
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Carros'

    expect(page).to have_content("Modelo: #{car_a.car_model.name}")
    expect(page).to have_content("Placa: #{car_a.license_plate}")
    expect(page).to have_content("Cor: #{car_a.color}")
    expect(page).to have_content("Km: #{car_a.milage}")
    expect(page).to have_content("Filial: #{car_a.subsidiary.name}")

    expect(page).to have_content("Modelo: #{car_b.car_model.name}")
    expect(page).to have_content("Placa: #{car_b.license_plate}")
    expect(page).to have_content("Cor: #{car_b.color}")
    expect(page).to have_content("Km: #{car_b.milage}")
    expect(page).to have_content("Filial: #{car_b.subsidiary.name}")
  end
end