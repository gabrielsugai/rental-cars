require 'rails_helper'

feature 'Admin deletes manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Apagar fabricante'

    expect(current_path).to eq manufacturers_path
    expect(page).to have_content('Nenhum fabricante cadastrado')
  end

  scenario 'and keep anothers' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Apagar fabricante'

    expect(current_path).to eq manufacturers_path
    expect(page).not_to have_content('Fiat')
    expect(page).to have_content('Honda')
  end
  scenario 'and link canot be blank' do
    expect(page).not_to have_link('Fabricantes')
  end
end
