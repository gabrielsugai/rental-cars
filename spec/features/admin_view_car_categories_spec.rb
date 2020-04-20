require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'successfully' do
    CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    CarCategory.create!(name:'B', daily_rate: 100.0, car_insurance: 60.0, third_party_insurance: 70.0)
    
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Diária: R$ 80,00')
    expect(page).to have_content('Categoria B')
    expect(page).to have_content('Diária: R$ 100,00')
  end

  scenario 'and view details' do
    CarCategory.create!(name:'A', daily_rate: 80.0, car_insurance: 40.0, third_party_insurance: 50.0)
    CarCategory.create!(name:'B', daily_rate: 100.0, car_insurance: 60.0, third_party_insurance: 70.0)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria A'

    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Diária: R$ 80,00')
    expect(page).to have_content('Seguro: R$ 40,00')
    expect(page).to have_content('Seguro de terceiros: R$ 50,00')

    expect(page).not_to have_content('Categoria B')
    expect(page).not_to have_content('Diária: R$ 100,00')
    expect(page).not_to have_content('Seguro: R$ 60,00')
    expect(page).not_to have_content('Seguro de terceiros: R$ 70,00')
  end
end