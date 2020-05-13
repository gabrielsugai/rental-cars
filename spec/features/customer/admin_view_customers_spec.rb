require 'rails_helper'

feature 'Admin view customers' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    Customer.create!(name: 'José', cpf: '036.842.590-80', email: 'jose@teste.com')
    Customer.create!(name: 'Maria', cpf: '705.162.740-66', email: 'maria@teste.com')

    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('José')
    expect(page).to have_content('036.842.590-80')
    expect(page).to have_content('jose@teste.com')
    expect(page).to have_content('Maria')
    expect(page).to have_content('705.162.740-66')
    expect(page).to have_content('maria@teste.com')
  end

  scenario 'and link canot be found' do
    expect(page).not_to have_link('Clientes')
  end
end