require 'rails_helper'

describe 'Usuário vê o estoque' do
    it 'na tela do galpão' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
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

        3.times{StockProduct.create!(order:order, warehouse: warehouse,product_model:first_product)}
        2.times{StockProduct.create!(order:order, warehouse: warehouse,product_model:second_product)}

        login_as(user)
        visit(root_path)
        click_on('Maceio')
        
        within('section') do
            expect(page).to have_content('3 x TV 32')
            expect(page).to have_content('2 x Controle PS5')
            expect(page).not_to have_content('HD 1T')
        end
    end
    it 'e dá baixa' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
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
        product = ProductModel.create!(
            name:'TV 32',weight:8000,height:70,width:45,
            depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
        )
        3.times{StockProduct.create!(order:order, warehouse: warehouse,product_model:product)}
    
        login_as(user)
        visit(root_path)
        click_on('Maceio')
        select 'TV 32', from: 'Item para saída'
        fill_in 'Destinatário', with: 'Maria Ferreira'
        fill_in 'Endereço Destino', with: 'Avenida Reis'
        click_on 'Confirmar Retirada'

        expect(current_path).to eq warehouse_path(warehouse.id)
        expect(page).to have_content 'Item retirado com sucesso'
        expect(page).to have_content '2 x TV 32'
    end
end