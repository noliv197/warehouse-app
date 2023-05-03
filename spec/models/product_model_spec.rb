require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    describe '#dimensions?' do
        it 'exibe dimensões do produto' do
            supplier = Supplier.new(
                corporate_name: 'Galpões&CIA',brand_name:'GC',
                cnpj:'1234567899874',registration_number: '456871321',
                full_address: 'Avenida copacabana',city:'Rio de Janeiro',
                state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
            )
            product = ProductModel.new(name:'TV 32',weight:8000,height:70,width:45,
                depth:10,sku:'TV32-SAMSU-TXP907895',supplier: supplier
            )

            result = product.dimensions

            expect(result).to eq '70cm x 45cm x 10cm'
        end
    end
end
