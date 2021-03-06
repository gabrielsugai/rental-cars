require 'rails_helper'

feature 'Admin register a new car category' do
  context 'logado' do
    scenario 'successfully' do
    user = User.create!(email: 'test@test.com.br', password: '12345678')
    login_as user, scope: :user
    #Arrange
    
    #Act
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'
    
    fill_in 'Nome da categoria', with: 'A'
    fill_in 'Diária', with: '80.0'
    fill_in 'Seguro', with: '40.0'
    fill_in 'Seguro de terceiros', with: '50.0'
    click_on 'Enviar'
    
    #assert
    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Diária: R$ 80,00')
    expect(page).to have_content('Seguro: R$ 40,00')
    expect(page).to have_content('Seguro de terceiros: R$ 50,00')
    end
  end

  context 'não logado' do
    scenario 'link not be found' do
    expect(page).not_to have_link('Categorias de carros')
    end
  end
  
end


