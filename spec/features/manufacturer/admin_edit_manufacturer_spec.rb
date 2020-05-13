require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end
end
