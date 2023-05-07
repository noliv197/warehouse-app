require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
    it 'com sucesso' do
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
        first_product = ProductModel.create!(
            name:'TV 32',weight:8000,height:70,width:45,
            depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
        )
        second_product = ProductModel.create!(
            name:'Controle PS5',weight:20,height:30,width:30,
            depth:5,sku:'CXE78RF5R8E9T8SD568R',supplier: supplier
        )
        order = Order.create!(
            user: user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'

        select 'TV 32', from: 'Produto'
        fill_in 'Quantidade', with: 19
        click_on 'Gravar'

        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content 'Item adicionado com sucesso'
        expect(page).to have_content '19 x TV 32'  
    end
    it 'com fracasso' do
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
        first_product = ProductModel.create!(
            name:'TV 32',weight:8000,height:70,width:45,
            depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
        )
        second_product = ProductModel.create!(
            name:'Controle PS5',weight:20,height:30,width:30,
            depth:5,sku:'CXE78RF5R8E9T8SD568R',supplier: supplier
        )
        order = Order.create!(
            user: user, warehouse: warehouse,
            supplier:supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'

        select 'TV 32', from: 'Produto'
        fill_in 'Quantidade', with: ''
        click_on 'Gravar'

        expect(page).to have_content 'Não foi possivel adicionar o item'
    end
    it 'e não vê produtos de outros fornecedores' do
        user = User.create!(username:'ana',email:'ana@email.com',password:'12345678')
        first_supplier = Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',
            cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',
            state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        second_supplier = Supplier.create!(
            corporate_name: 'Amazon',brand_name:'Amazon',
            cnpj:'9874563214568',registration_number: '89575213',
            full_address: 'Avenida central',city:'São Paulo',
            state:'SP',email:'amazon@gmail.com',phone:'(61)985472563'
        )
        warehouse = Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        first_product = ProductModel.create!(
            name:'TV 32',weight:8000,height:70,width:45,
            depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: first_supplier
        )
        second_product = ProductModel.create!(
            name:'Controle PS5',weight:20,height:30,width:30,
            depth:5,sku:'CXE78RF5R8E9T8SD568R',supplier: second_supplier
        )
        third_product = ProductModel.create!(
            name:'HD 1T',weight:50,height:20,width:10,
            depth:5,sku:'DRF54G8T5R2F3C6D5E8T',supplier: second_supplier
        )
        order = Order.create!(
            user: user, warehouse: warehouse,
            supplier:second_supplier, estimated_delivery_date: 1.day.from_now
        )

        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'

        expect(page).not_to have_content 'TV 32'
        expect(page).to have_content 'Controle PS5'
        expect(page).to have_content 'HD 1T'  
    end
end