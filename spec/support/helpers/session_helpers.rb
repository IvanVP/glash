module Features
  module SessionHelpers
    def sign_up_with(fname, lname, name, email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Имя', with: fname
      fill_in 'Фамилия', with: lname
      fill_in 'Логин', with: name
      fill_in 'Email', with: email
      fill_in 'Пароль', with: password
      fill_in 'Еще раз пароль', :with => confirmation
      check('Согласен с ')
      click_button 'Регистрация'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Логин', with: email
      fill_in 'Пароль', with: password
      click_button 'Войти'
    end
  end
end
