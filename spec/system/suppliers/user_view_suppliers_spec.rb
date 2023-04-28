require 'rails_helper'

describe 'Usuário vê lista de fornecedores' do
    it 'a partir do menu' do
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        
        expect(current_path).to eq(suppliers_path)
    end 
    it 'com sucesso' do
        Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        expect(page).to have_content('GC')
        expect(page).to have_content('Rio de Janeiro - RJ')
    end 
    it 'vazia' do
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        expect(page).to have_content('Não existem fornecedores cadastrados')
    end 
end