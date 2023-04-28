require 'rails_helper'

describe 'Usuário deleta galpão cadastrado' do
    it 'com sucesso' do
        # Arrange
        Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        # Act
        visit root_path
        click_on 'Maceio'
        click_on 'Deletar Galpão'
        # Assert
        expect(current_path).to eq(root_path)
        expect(page).not_to have_content('Maceio')
        expect(page).not_to have_content('MCZ')
        expect(page).not_to have_content('50000')

    end
    it 'e não apaga outros galpões' do
        # Arrange
        first_warehouse = Warehouse.create!(
            name: 'Maceio', code: 'MCZ',city: 'Maceio', area: 50000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        second_warehouse = Warehouse.create!(
            name: 'Aeroporto Rio', code: 'SDU',
            city: 'Rio de Janeiro', area: 60000,
            address:'Avenida do Aeroporto',zip:'414444100',
            description:'Galpão destinado para cargas internacionais'
        )
        # Act
        visit root_path
        click_on 'Maceio'
        click_on 'Deletar Galpão'
        # Assert
        expect(page).to have_content('Aeroporto Rio')
        expect(page).not_to have_content('Maceio')
    end
end