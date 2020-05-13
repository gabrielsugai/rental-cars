require 'rails_helper'

feature 'Admin view car models' do
  scenario 'successfully' do
    fiat = Manufacturer.create!(name: 'Fiat')
    ford = Manufacturer.create!(name: 'Ford')
    category = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)

    CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: category)

    CarModel.create!(name: 'Ka', year: 2020, manufacturer: ford, motorization: '1.0', fuel_type: 'Flex', car_category: category)

    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user

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
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    #Act
    visit root_path
    click_on 'Modelos de Carros'

    #Assert
    expect(page).to have_content('Nenhum modelo cadastrado.')
  end

  scenario 'and view details' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    #Arrange
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    cat_e = CarCategory.create!(name:'E', daily_rate: 200.0, car_insurance: 90.0, third_party_insurance: 100.0)

    cm = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)

    CarModel.create!(name: 'Toro', year: 2020, manufacturer: fiat, motorization: '2.0 Turbo', fuel_type: 'Diesel', car_category: cat_e)

    #Act
    visit root_path
    click_on 'Modelos de Carros'

    #Resolvendo ambiguidade -> click_on "details-#{cm.id}" ou find("a#details-#{cm.id}").click()
    #Ou \/ 
    within("tr#car-model-#{cm.id}") do
      click_on 'Ver Detalhes'
    end

    #Assert
    expect(page).to have_content('Uno')
    expect(page).to have_content('Fabricante: Fiat')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Motor: 1.0')
    expect(page).to have_content('Combustível: Flex')
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Diária: R$ 80,00')

    expect(page).not_to have_content('Toro')
    expect(page).not_to have_content('Motor: 2.0 Turbo')
    expect(page).not_to have_content('Combustível: Diesel')
    expect(page).not_to have_content('Categoria: E')
    expect(page).not_to have_content('Diária: R$ 200,00')
  end

  scenario 'and return to index' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    visit root_path
    click_on 'Modelos de Carros'

    click_on "Voltar"
    
    expect(current_path).to eq root_path
  end

  scenario 'view details, and return to models' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    #Arrange
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    cm = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)

    #Act
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Ver Detalhes'

    click_on 'Voltar'

    #Assert
    expect(current_path).to eq car_models_path
  end

  scenario 'and link canot be found' do
    expect(page).not_to have_link('Modelos de Carros')
  end
end