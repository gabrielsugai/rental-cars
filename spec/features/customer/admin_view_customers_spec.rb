require 'rails_helper'

feature 'Admin view customers' do
  scenario 'successfully' do
    Customer.create!(name: 'José', cpf: '036.842.590-80', email: 'jose@teste.com')
    Customer.create!(name: 'Maria', cpf: '705.162.740-66', email: 'maria@teste.com')

    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Clientes Cadastrados')
    expect(page).to have_content('José')
    expect(page).to have_content('Maria')
  end

  scenario 'and view details' do
    Customer.create!(name: 'José', cpf: '036.842.590-80', email: 'jose@teste.com')

    visit root_path
    click_on 'Clientes'
    click_on 'José'

    expect(page).to have_content('José')
    expect(page).to have_content('CPF: 036.842.590-80')
    expect(page).to have_content('Email: jose@teste.com')
  end
end