require 'rails_helper'

feature 'User register new customer' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar Cliente'

    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '036.842.590-80'
    fill_in 'Email', with: 'jose@teste.com'
    click_on 'Enviar'

    expect(page).to have_content('José')
    expect(page).to have_content('036.842.590-80')
    expect(page).to have_content('jose@teste.com')
  end

  scenario 'and link canot be found' do
    expect(page).not_to have_link('Clientes')
  end
end
