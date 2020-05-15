require 'rails_helper'

feature 'User view customer' do
  xscenario 'and view multiple customers' do
  end
  xscenario 'and view customer details' do  
  end
  xscenario 'without rentals' do
    expect(page).not_to have_link('Iniciar')
  end
end