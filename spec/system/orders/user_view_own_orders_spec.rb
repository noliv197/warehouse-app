require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
    it 'e deve estar auntenticado' do
        visit root_path
        click_on 'Meus Pedidos'

        expect(current_path).to eq new_user_session_path
    end
    it 'e não vê outros pedidos' do
        first_user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
        second_user = User.create!(username:'ana',email:'ana@email.com',password:'12345678')
        supplier = Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        warehouse = Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ12345')
        first_order = Order.create!(
            user: first_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ54321')
        second_order = Order.create!(
            user: second_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('GRU12345')
        third_order = Order.create!(
            user: first_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(first_user)
        visit root_path
        click_on 'Meus Pedidos'

        expect(page).to have_content 'Pedido MCZ12345' 
        expect(page).to have_content 'Pedido GRU12345' 
        expect(page).not_to have_content 'Pedido MCZ54321' 
    end
    it 'e não visita pedidos de outros usuários' do
        first_user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
        second_user = User.create!(username:'ana',email:'ana@email.com',password:'12345678')
        supplier = Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        warehouse = Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ12345')
        first_order = Order.create!(
            user: first_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ54321')
        second_order = Order.create!(
            user: second_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('GRU12345')
        third_order = Order.create!(
            user: first_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(second_user)
        visit order_path(first_order.id)

        expect(current_path).not_to eq order_path(first_order.id)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'e vê itens do pedido' do
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
        first_product = ProductModel.create!(
            name:'TV 32',weight:8000,height:70,width:45,
            depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
        )
        second_product = ProductModel.create!(
            name:'Controle PS5',weight:20,height:30,width:30,
            depth:5,sku:'CXE78RF5R8E9T8SD568R',supplier: supplier
        )
        third_product = ProductModel.create!(
            name:'HD 1T',weight:50,height:20,width:10,
            depth:5,sku:'DRF54G8T5R2F3C6D5E8T',supplier: supplier
        )
        order = Order.create!(
            user: user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        OrderItem.create(product_model: first_product, order: order, quantity: 19)
        OrderItem.create(product_model: second_product, order: order, quantity: 30)
    
        login_as user
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code

        expect(page).to have_content 'Itens do Pedido'
        expect(page).to have_content '19 x TV 32'
        expect(page).to have_content '30 x Controle PS5'
        expect(page).not_to have_content 'HD 1T'

    end
end