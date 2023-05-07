require 'rails_helper'

describe 'Usuário busca por um pedido' do
    it 'a partir do menu' do
        user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
        
        login_as(user)
        visit root_path

        within('header') do
            expect(page).to have_field('Buscar Pedido')
            expect(page).to have_button('Buscar')
        end
    end
    it 'e deve estar autenticado' do
        visit root_path

        within('header') do
            expect(page).not_to have_field('Buscar Pedido')
            expect(page).not_to have_button('Buscar')
        end
    end
    it 'com código exato e é redirecionado para sua página' do
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
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        Order.create!(
            user: user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: order.code
        click_on 'Buscar'

        expect(current_path).to eq order_path(order)
        expect(page).to have_content("Pedido #{order.code}")
    end
    it 'e encontra múltiplos pedidos' do
        user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
        supplier = Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        first_warehouse = Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        second_warehouse = Warehouse.create!(
            name: 'Aeroporto SP', code: 'GRU',city: 'São Paulo', area: 50000,
            address:'Avenida Brasil',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ12345')
        first_order = Order.create!(
            user: user, warehouse: first_warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ54123')
        second_order = Order.create!(
            user: user, warehouse: second_warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('GRU12345')
        third_order = Order.create!(
            user: user, warehouse: second_warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: 'MCZ'
        click_on 'Buscar'

        expect(page).to have_content("Resultados da Busca por: MCZ")
        expect(page).to have_content('2 Pedidos Encontrados')
        expect(page).to have_link("MCZ12345")
        expect(page).to have_link("MCZ54123")
        expect(page).not_to have_link("GRU12345")
    end
end