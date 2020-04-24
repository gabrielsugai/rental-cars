require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial', href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'GSCars'
    fill_in 'CNPJ', with: '74.303.466/0001-00'
    fill_in 'Endereço', with: 'Rua de terra, 33'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_content('GSCars')
    expect(page).to have_content('74.303.466/0001-00')
    expect(page).to have_content('Rua de terra, 33')
    expect(page).to have_link('Voltar')
  end
end
