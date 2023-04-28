require 'rails_helper'

describe 'Usuário entra na tela de cadastro de novo galpão' do
    it 'e vê formulario de cadastro' do
        # Arrange
        # Act
        visit(root_path)
        click_on('Cadastrar novo galpão')
        # Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Código')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Área')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Descrição')
    end
    it 'e cadastra um novo galpão' do
        # Arrange
        # Act
        visit(root_path)
        click_on('Cadastrar novo galpão')
        fill_in('Nome', with:'Rio')
        fill_in('Código', with: 'RIO')
        fill_in('Cidade', with: 'Rio de Janeiro')
        fill_in('Área', with: 50000)
        fill_in('Endereço', with: 'Copacabana')
        fill_in('CEP', with: '78945685689')
        fill_in('Descrição', with: 'Galpão da zona portuária')
        click_on('Salvar')
        # Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Código: RIO')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('Área: 50000 m2')
    end
    it 'e cadastro não é concluido' do
        # Arrange
        # Act
        visit(root_path)
        click_on('Cadastrar novo galpão')
        fill_in('Nome', with:'')
        fill_in('Código', with: '')
        click_on('Salvar')
        # Assert
        expect(page).to have_content('Galpão não cadastrado')
    end
end