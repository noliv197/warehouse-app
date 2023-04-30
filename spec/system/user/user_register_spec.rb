require 'rails_helper'

describe 'Usuário se registra' do
    it 'com sucesso' do
        visit root_path
        click_on 'Entrar'
        click_on 'Criar conta'
        within('form') do
            fill_in 'Nome de usuário', with: 'natalia'
            fill_in 'E-mail', with: 'natalia@email.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirme sua senha', with: '12345678'
            click_on 'Fazer cadastro'
        end

        within('nav') do
            expect(page).to have_button 'Sair'
            expect(page).to have_content 'natalia'
        end
        expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso'
    end
    it 'com fracasso' do
        visit root_path
        click_on 'Entrar'
        click_on 'Criar conta'
        within('form') do
            fill_in 'Nome de usuário', with: 'natalia'
            fill_in 'E-mail', with: 'natalia@email.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirme sua senha', with: '87451233'
            click_on 'Fazer cadastro'
        end
        expect(page).to have_content 'Não foi possível salvar usuário'
    end

end