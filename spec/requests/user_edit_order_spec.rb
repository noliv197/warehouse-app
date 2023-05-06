require 'rails_helper'

describe 'Usuário edita um pedido' do
    it 'e não é o dono' do
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
        patch(order_path(order.id), params: {order: {estimated_delivery_date: 1.year.from_now}})
        
        expect(response).to redirect_to(root_path)
    end
end