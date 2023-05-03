require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê o nome do app' do
        # Arrange
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit(root_path)
        # Assert
        expect(page).to have_content('Galpões & Estoque')
        expect(page).to have_link('Galpões & Estoque', href: root_path)
    end
    it 'e vê lista de galpões' do
        # Arrange
        Warehouse.create(
            name: 'Aeroporto Rio', code: 'SDU',
            city: 'Rio de Janeiro', area: 60000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        Warehouse.create(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit(root_path)
        # Assert
        expect(page).not_to have_content('Nenhum galpão cadastrado')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m2')

        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000 m2')
    end
    it 'e não tem nenhum galpão cadastrado' do
        # Arrange
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit(root_path)
        # Assert
        expect(page).to have_content('Nenhum galpão cadastrado')
    end
end