require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
        # Arrange
        Warehouse.create(name: 'Aeroporto Rio', code: 'SDU',
                         city: 'Rio de Janeiro', area: 60000,
                         address:'Avenida do Aeroporto',zip:'414444100',
                         description:'Galpão destinado para cargas internacionais'
                        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit(root_path)
        click_on('Aeroporto Rio')
        # Assert
        expect(page).to have_content('Galpão SDU')
        expect(page).to have_content('Nome: Aeroporto Rio')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('Área: 60000 m2')
        expect(page).to have_content('Endereço: Avenida do Aeroporto, 414444100')
        expect(page).to have_content('Descrição: Galpão destinado para cargas internacionais')
    end
    it 'e volta para homepage' do
        # Arrange
        Warehouse.create(name: 'Aeroporto Rio', code: 'SDU',
            city: 'Rio de Janeiro', area: 60000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        # Act
        visit(root_path)
        click_on('Aeroporto Rio')
        click_on('Voltar para Homepage')
        # Assert
        expect(current_path).to eq(root_path)
    end
end