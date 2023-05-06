require 'rails_helper'

describe 'Usuário edita pedido' do
    it 'e deve estar auntenticado' do
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
        visit edit_order_path(order.id)

        expect(current_path).to eq new_user_session_path
    end
    it 'com sucesso' do
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
        formatted_date_present = I18n.localize(1.year.from_now.to_date)
        formatted_date_past = I18n.localize(1.day.from_now.to_date)
        order = Order.create!(
            user: user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: formatted_date_past
        )
        Order.create!(
            user: user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: formatted_date_past
        )

        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Editar'
        fill_in 'Data Estimada de Entrega', with: formatted_date_present
        click_on 'Gravar'
        
        expect(page).to have_content'Atualizações feitas com sucesso'
        expect(page).to have_content "Data Estimada de Entrega: #{formatted_date_present}"
        expect(page).not_to have_content "Data Estimada de Entrega: #{formatted_date_past}"
    end

    it 'caso seja o responsável' do
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
        order = Order.create!(
            user: second_user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(first_user)
        visit edit_order_path(order.id)
        
        expect(current_path).to eq root_path
    end
end