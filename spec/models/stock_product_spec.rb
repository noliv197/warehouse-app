require 'rails_helper'

RSpec.describe StockProduct, type: :model do
    describe 'gera um número de série' do
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
            order = Order.create!(
                user: user, warehouse: warehouse ,
                supplier:supplier, estimated_delivery_date: 1.day.from_now
            )
            product = ProductModel.create!(
                name:'TV 32',weight:8000,height:70,width:45,
                depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
            )

            stock = StockProduct.create!(order:order, warehouse: warehouse,product_model:product)
        
            expect(stock.serial_number.length).to eq 20
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
                user: user, warehouse: warehouse ,
                supplier:supplier, estimated_delivery_date: 1.day.from_now
            )
            second_order = Order.create!(
                user: user, warehouse: warehouse ,
                supplier:supplier, estimated_delivery_date: 1.week.from_now
            )
            product = ProductModel.create!(
                name:'TV 32',weight:8000,height:70,width:45,
                depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
            )

            stock = StockProduct.create!(order:order, warehouse: warehouse,product_model:product)
            original_serial_number = stock.serial_number
            stock.update!(order:second_order)

            expect(original_serial_number).to eq stock.serial_number
        end
    end
    describe '#available?' do
        it 'true se não tiver destino' do
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
                user: user, warehouse: warehouse ,
                supplier:supplier, estimated_delivery_date: 1.day.from_now
            )
            product = ProductModel.create!(
                name:'TV 32',weight:8000,height:70,width:45,
                depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
            )

            stock = StockProduct.create!(order:order, warehouse: warehouse,product_model:product)
            
            expect(stock.available?).to eq true
        end
        it 'false se tiver destino' do
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
                user: user, warehouse: warehouse ,
                supplier:supplier, estimated_delivery_date: 1.day.from_now
            )
            product = ProductModel.create!(
                name:'TV 32',weight:8000,height:70,width:45,
                depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
            )

            stock = StockProduct.create!(order:order, warehouse: warehouse,product_model:product)
            stock.create_stock_product_destination!(recipient:'joão',address:'Avenida brasil')
            
            expect(stock.available?).to eq false
        end
    end
end
