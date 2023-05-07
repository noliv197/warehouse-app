require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
    it 'para pedido entregue' do
        user = User.create!(username:'ana',email:'ana@email.com',password:'12345678')
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

        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Marcar como ENTREGUE'

        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content 'Situação do Pedido: Entregue' 
        expect(page).not_to have_button 'Marcar como ENTREGUE'    
        expect(page).not_to have_button 'Cancelar Pedido'  
    end
    it 'para pedido cancelado' do
        user = User.create!(username:'ana',email:'ana@email.com',password:'12345678')
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

        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Cancelar Pedido'

        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content 'Situação do Pedido: Cancelado'
        expect(page).not_to have_button 'Marcar como ENTREGUE'  
        expect(page).not_to have_button 'Cancelar Pedido'     
    end
end