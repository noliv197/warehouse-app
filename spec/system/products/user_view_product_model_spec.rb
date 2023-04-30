require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'a partir do menu sem autenticação'do
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        expect(current_path).to eq(new_user_session_path)
    end
    it 'a partir do menu com autenticação' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        expect(current_path).to eq(product_models_path)
    end
    it 'com sucesso' do
        supplier = Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        ProductModel.create!(
            name:'TV 32',weight:8000,height:70,width:45,
            depth:10,sku:'TV32-SAMSU-TXP90-CS9',supplier: supplier
        )
        ProductModel.create!(
            name:'Controle PS5',weight:20,height:30,width:30,
            depth:5,sku:'CXE78RF5R8E9T8SD568R',supplier: supplier
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        expect(page).to have_content('TV 32')
        expect(page).to have_content('TV32-SAMSU-TXP90-CS9')
        expect(page).to have_content('Galpões&CIA')
        expect(page).to have_content('Controle PS5')
        expect(page).to have_content('CXE78RF5R8E9T8SD568R')
    end
    it 'mas nenhum modelo está cadastrado' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        expect(page).to have_content('Nenhum modelo de produto cadastrado')
    end
end