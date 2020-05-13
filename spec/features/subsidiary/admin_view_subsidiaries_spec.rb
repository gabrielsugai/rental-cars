require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')
    Subsidiary.create!(name: 'SCars', cnpj: '84.243.263/0001-11', address: 'Rua reta, 321')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('GCars')
    expect(page).to have_content('SCars')
  end

  scenario 'and view details' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')
    Subsidiary.create!(name: 'SCars', cnpj: '84.243.263/0001-11', address: 'Rua reta, 321')

    visit root_path
    click_on 'Filiais'
    click_on 'GCars'

    expect(page).to have_content('GCars')
    expect(page).to have_content('74.303.466/0001-00')
    expect(page).to have_content('Rua curva, 123')

    expect(page).not_to have_content('SCars')
    expect(page).not_to have_content('84.243.263/0001-11')
    expect(page).not_to have_content('Rua reta, 321')
  end

  scenario 'and no subsidiaries are created' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Subsidiary.create!(name: 'GCars', cnpj: '74.303.466/0001-00', address: 'Rua curva, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'GCars'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
