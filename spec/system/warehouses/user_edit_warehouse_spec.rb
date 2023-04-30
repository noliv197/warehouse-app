require 'rails_helper'

describe 'Usuário edita galpão' do
    it 'e tem sucesso' do
        # Arrange
        Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit root_path
        click_on('Maceio')
        click_on('Editar')
        fill_in('CEP', with: '78945687')
        click_on('Salvar')
        # Assert
        expect(page).not_to have_content('414444100')
        expect(page).to have_content('78945687')
    end
    it 'e tem fracasso' do
        # Arrange
        Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit root_path
        click_on('Maceio')
        click_on('Editar')
        fill_in('CEP', with: '')
        click_on('Salvar')
        # Assert
        expect(page).to have_content('Não foi possivel salvar as alterações')
    end
end