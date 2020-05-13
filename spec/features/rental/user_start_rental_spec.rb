require 'rails_helper'

feature 'User start rental' do
  scenario 'successfully' do
    customer = Customer.create!(name: 'Fulano Sicrano', 
                                cpf: '185.972.440-03', 
                                email: 'teste@teste.com.br')
    
    manufacturer = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name: 'A', daily_rate: 100, 
                                      car_insurance: 100, 
                                      third_party_insurance: 100)
    cm = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
                          motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)
    
    subs = Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')
    
    car = Car.create!(license_plate: 'ABC1234', color: 'Preto', milage: 0, car_model: cm, 
                        subsidiary: subs)
    
    rental = Rental.create!(customer: customer, car_category: cat_a,
                            start_date: 1.day.from_now, 
                            end_date: 2.days.from_now)
    
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    visit search_rentals_path(q: rental.code)

    click_on 'Iniciar'
    select car.license_plate, from: 'Carro'
    click_on 'Confirmar locação'

    expect(page).to have_content(I18n.l(Time.zone.now, format: :long))
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(user.email)
  end
end