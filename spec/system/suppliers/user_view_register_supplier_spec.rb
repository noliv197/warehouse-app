require 'rails_helper'

describe 'Usuário entra na página de fornecedores' do
    it 'e entra na tela de cadastro' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit suppliers_path
        click_on 'Cadastrar novo Fornecedor'
        expect(page).to have_field('Nome da Corporação')
        expect(page).to have_field('Nome da Marca')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Número de Registro')
        expect(page).to have_field('Endereço Completo')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
        expect(page).to have_field('Email')
        expect(page).to have_field('Telefone')
    end
    it 'e cadastra fornecedor com sucesso' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit suppliers_path
        click_on 'Cadastrar novo Fornecedor'
        fill_in('Nome da Corporação',with: 'Amazon')
        fill_in('Nome da Marca',with: 'Amazon')
        fill_in('CNPJ',with: '1234567899874')
        fill_in('Número de Registro',with: '4568979')
        fill_in('Endereço Completo',with: 'Avenida Central')
        fill_in('Cidade',with: 'São Paulo')
        fill_in('Estado',with: 'SP')
        fill_in('Email',with: 'amazon@gmail.com')
        fill_in('Telefone',with: '(61)986589475')
        click_on('Salvar')
        expect(current_path).to eq(suppliers_path)
        expect(page).to have_content('Amazon')
        expect(page).to have_content('São Paulo - SP')
    end
    it 'e não consegue cadastrar fornecedor' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        
        visit suppliers_path
        click_on 'Cadastrar novo Fornecedor'
        fill_in('Endereço Completo',with: '')
        fill_in('Cidade',with: '')
        fill_in('Estado',with: '')
        click_on('Salvar')
        expect(page).to have_content('Não foi possível cadastrar fornecedor')
    end
end