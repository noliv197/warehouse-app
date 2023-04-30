require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'E-mail', with: 'natalia@email.com'
            fill_in 'Senha', with: '12345678'
            click_on 'Login'
        end

        within('nav') do
            expect(page).not_to have_link 'Entrar'
            expect(page).to have_button 'Sair'
            expect(page).to have_content 'natalia'
        end
        expect(page).to have_content 'Login efetuado com sucesso'
    end
    it 'e faz logout' do
        user = User.create!(username:'natalia',email:'natalia@email.com',password:'12345678')
        login_as(user)

        visit root_path
        click_on 'Sair'

        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
        expect(page).not_to have_content 'natalia'
    end
end