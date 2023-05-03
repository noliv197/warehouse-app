require 'rails_helper'

describe 'Usuário cadastra um pedido' do
    it 'e precisa de autenticação' do
        visit root_path
        click_on 'Registrar Pedido'

        expect(current_path).to eq new_user_session_path
    end
    it 'com sucesso' do
        warehouse = Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        Warehouse.create!(
            name: 'Aeroporto Rio', code: 'SDU',
            city: 'Rio de Janeiro', area: 60000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        supplier = Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        Supplier.create!(
            corporate_name: 'Amazon',brand_name:'AMZ',cnpj:'9874563214568',registration_number: '884546546',
            full_address: 'Avenida Brasil',city:'São Paulo',state:'SP',email:'amazon@gmail.com',phone:'(61)956899856'
        )
        user = User.create!(username:'Natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit root_path
        click_on 'Registrar Pedido'
        select 'MCZ | Maceio', from: 'Galpão Destino'
        select 'GC | Galpões&CIA', from: 'Fornecedor'
        fill_in 'Data Estimada de Entrega', with: '20/12/2023'
        click_on 'Gravar'

        expect(page).not_to have_content 'Aeroporto Rio'
        expect(page).not_to have_content 'Amazon'
        expect(page).to have_content 'Pedido registrado com sucesso'
        expect(page).to have_content 'Galpão Destino: Maceio'
        expect(page).to have_content 'Fornecedor: Galpões&CIA'
        expect(page).to have_content 'Data Estimada de Entrega: 20/12/2023'
        expect(page).to have_content 'Funcionário Responsável: Natalia < natalia@email.com >'
    end

end