require 'rails_helper'

feature 'Admin view car models' do
  scenario 'successfully' do
    fiat = Manufacturer.create!(name: 'Fiat')
    ford = Manufacturer.create!(name: 'Ford')
    category = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)

    CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: category)

    CarModel.create!(name: 'Ka', year: 2020, manufacturer: ford, motorization: '1.0', fuel_type: 'Flex', car_category: category)

    #Act
    visit root_path
    click_on 'Modelos de Carros'
    #Assert
    expect(page).to have_content 'Fiat'
    expect(page).to have_content 'Uno'
    expect(page).to have_content '2020'

    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Ka'
    expect(page).to have_content '2020'
  end

  scenario 'no car models' do
    
  end

  scenario 'and view details' do
    #Arrange
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    

    CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)

    #Act
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Ver Detalhes'

    #Assert
    expect(page).to have_content('Uno')
    expect(page).to have_content('Fabricante: Fiat')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Motor: 1.0')
    expect(page).to have_content('Combustível: Flex')
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Diária: R$ 80,00')
  end
end