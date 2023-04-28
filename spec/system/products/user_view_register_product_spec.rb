require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
    it 'com sucesso' do
        Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar novos Modelos de Produtos'
        fill_in 'Nome', with: 'Controle PS5'
        fill_in 'Peso', with: '5'
        fill_in 'Altura', with: '2'
        fill_in 'Largura', with: '15'
        fill_in 'Profundidade', with: '3'
        fill_in 'Código', with: 'CXE78RF5R8E9T8SD568R'
        select 'Galpões&CIA', from: 'Fornecedor'
        click_on 'Salvar'

        expect(page).to have_content 'Produto cadastrado com sucesso'
        expect(page).to have_content 'Controle PS5'
        expect(page).to have_content 'CXE78RF5R8E9T8SD568R'
        expect(page).to have_content 'Fornecedor'
    end
    it 'com fracasso' do
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar novos Modelos de Produtos'
        click_on 'Salvar'

        expect(page).to have_content 'Não foi possível cadastrar produto'
    end
end