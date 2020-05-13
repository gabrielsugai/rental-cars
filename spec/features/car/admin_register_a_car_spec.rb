require 'rails_helper'

feature 'Admin register a car' do
  scenario 'successfully' do
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    subs = Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')
    cm = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, 
                          motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Carros'
    click_on 'Registrar novo carro'

    select cm.name, from: 'Modelo'
    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Km', with: 0
    select subs.name, from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content("Modelo: #{cm.name}")
    expect(page).to have_content('Placa: ABC1234')
    expect(page).to have_content('Cor: Preto')
    expect(page).to have_content('Km: 0')
    expect(page).to have_content("Filial: #{subs.name}")
  end
  scenario 'and link canot be found' do
    expect(page).not_to have_link('Carros')
  end
end