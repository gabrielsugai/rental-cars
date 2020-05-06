require 'rails_helper'

feature 'User search customer' do
  scenario 'by exact name' do
    user = User.create!(email: 'email@test.com', password: '12345678')
    customer = Customer.create!(name: 'Fulano Sicrano', 
                                email: 'fulano@email.com',
                                cpf: '116.801.156-69')
    another_customer = Customer.create!(name: 'João da Silva', 
                                        email: 'joao@dasilva.com',
                                        cpf: '581.280.655-13')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: customer.name
    click_on 'Buscar'

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.cpf)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.cpf)
  end

  scenario 'by part name' do
    user = User.create!(email: 'email@test.com', password: '12345678')
    customer = Customer.create!(name: 'Fulano Sicrano', 
                                email: 'fulano@email.com',
                                cpf: '116.801.156-69')
    another_customer = Customer.create!(name: 'João da Silva', 
                                        email: 'joao@dasilva.com',
                                        cpf: '581.280.655-13')

    login_as user, scope: :user
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: 'Fulano'
    click_on 'Buscar'

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.cpf)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.cpf)
  end
end