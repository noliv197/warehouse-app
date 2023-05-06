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
end