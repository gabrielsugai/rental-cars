require 'rails_helper'

feature 'User register new customer' do
  xscenario 'successfully' do
    
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar Cliete'

    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '036.842.590-80'
    fill_in 'Email', with: 'jose@teste.com'
    click_on 'Enviar'

    expect(page).to have_content('José')
    expect(page).to have_content('CPF: 036.842.590-80')
    expect(page).to have_content('Email: jose@teste.com')
  end
end
