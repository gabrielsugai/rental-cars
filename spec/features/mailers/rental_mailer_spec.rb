require 'rails_helper'

describe RentalsMailer do
  context '#scheduled' do
    let(:customer) {Customer.create!(name: 'Fulano Sicrano', 
                                 cpf: '185.972.440-03', 
                                email: 'teste@teste.com.br')}
    let(:car_category) {CarCategory.create!(name: 'A', daily_rate: 100, 
                                          car_insurance: 100,
                                          third_party_insurance: 100)}
    let(:rental) {Rental.create!(customer: customer, car_category: car_category,
                                            start_date: 1.day.from_now, 
                                            end_date: 2.days.from_now)}
    let(:mail) {RentalsMailer.scheduled(rental)}
    it 'renders subject' do
      expect(mail.subject).to eq("Confirmação de Agendamento - #{rental.code}")
    end

    it 'renders receiver' do
      expect(mail.to).to eq([rental.customer.email])
    end

    it 'renders mail body' do
      expect(mail.body.encoded).to match(rental.code)
      expect(mail.body.encoded).to match(I18n.l(rental.start_date))
      expect(mail.body.encoded).to match(I18n.l(rental.end_date))
    end
  end
end