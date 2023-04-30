require 'rails_helper'

describe 'Usuário edita galpão' do
    it 'e tem sucesso' do
        Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit suppliers_path
        click_on 'GC'
        click_on 'Editar'
        fill_in('CNPJ', with: '9874563215689')
        click_on 'Salvar'

        expect(page).not_to have_content('1234567899874')
        expect(page).to have_content('9874563215689')
    end
    it 'e não consegue' do
        Supplier.create!(
            corporate_name: 'Galpões&CIA',brand_name:'GC',cnpj:'1234567899874',registration_number: '456871321',
            full_address: 'Avenida copacabana',city:'Rio de Janeiro',state:'RJ',email:'galpoesecia@gmail.com',phone:'(61)956899856'
        )
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)
        
        visit suppliers_path
        click_on 'GC'
        click_on 'Editar'
        fill_in('CNPJ', with: '')
        click_on 'Salvar'

        expect(page).to have_content('Não foi possivel salvar as alterações')
    end
end