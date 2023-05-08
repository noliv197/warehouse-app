require 'rails_helper'

RSpec.describe Order, type: :model do
    describe 'gera código aleatório' do
        it 'ao criar um novo pedido' do
            user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
            supplier = Supplier.create!(
                corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
                full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
            )
            warehouse = Warehouse.create!(
                name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
                address:'Avenida do Aeroporto',zip:'414444100',
                description:'Galpão destinado para cargas internacionais'
            )
            order = Order.new(
                user: user, warehouse: warehouse,
                supplier:supplier, estimated_delivery_date: '2023-10-01'
            )

            order.save!
            result = order.code

            expect(result).not_to be_empty
            expect(result.length).to eq 8
        end
        it 'e o código é unico' do
            user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
            supplier = Supplier.create!(
                corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
                full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
            )
            warehouse = Warehouse.create!(
                name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
                address:'Avenida do Aeroporto',zip:'414444100',
                description:'Galpão destinado para cargas internacionais'
            )
            first_order = Order.create!(
                user: user, warehouse: warehouse,
                supplier:supplier, estimated_delivery_date: '2023-10-01'
            )
            second_order = Order.new(
                user: user, warehouse: warehouse,
                supplier:supplier, estimated_delivery_date: '2023-10-01'
            )

            second_order.save!

            expect(second_order.code).not_to eq first_order.code
        end
        it 'e não pode ser modificado' do
            user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
            supplier = Supplier.create!(
                corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
                full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
            )
            warehouse = Warehouse.create!(
                name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
                address:'Avenida do Aeroporto',zip:'414444100',
                description:'Galpão destinado para cargas internacionais'
            )
            order = Order.create!(
                user: user, warehouse: warehouse,
                supplier:supplier, estimated_delivery_date: 1.week.from_now
            )
            
            original_code = order.code
            order.update!(estimated_delivery_date: 3.months.from_now)
            
            expect(original_code).to eq order.code
        end
    end
    describe '#valid?' do
        it 'e a data estimada não pode estar vazia' do
            order = Order.new(estimated_delivery_date: '')

            order.valid?
            result = order.errors.include? :estimated_delivery_date

            expect(result).to eq true
        end
        it 'e a data estimada não pode estar no passado' do
            order = Order.new(estimated_delivery_date: 3.days.ago)

            order.valid?
            result = order.errors

            expect(result.include? :estimated_delivery_date).to eq true
            expect(result[:estimated_delivery_date]).to include(' não pode estar no passado')
        end
    end
end
