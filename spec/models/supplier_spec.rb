require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#full_description' do
    it 'exibe nome fantasia e o cnpj' do
      supplier = Supplier.new(
        corporate_name: 'Galpões&CIA',brand_name:'GC',
        cnpj:'1234567899874',registration_number: '456871321',
        full_address: 'Avenida copacabana',city:'Rio de Janeiro',
        state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
      )

      result = supplier.full_description

      expect(result).to eq('GC | Galpões&CIA')
    end
  end
end
