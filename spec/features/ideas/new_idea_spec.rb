include Warden::Test::Helpers
Warden.test_mode!
require 'i18n'

# Feature: Commit new idea
#   As a user
#   I want to commit new idea
#   So I can create new idea with valid data
feature 'User creates new idea', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User creates idea with valid data
  #   Given I am signed in
  #   When I visit new idea page
  #   And fill all fields with valid data
  #   Then I see an idea created message
  scenario 'user creates new idea' do
    user = create(:user)
    idea = create(:idea)
    login_as(user, :scope => :user)
    visit new_idea_path
    fill_in 'idea_title', :with => idea.title
    fill_in 'idea_synopsis', :with => idea.synopsis
    fill_in 'idea_problem', :with => idea.problem
    fill_in 'idea_background', :with => idea.background
    fill_in 'idea_solution', :with => idea.solution
    fill_in 'idea_links', :with => idea.links
    # fill_in 'idea_links', :with => idea.links
    # fill_in 'idea_links', :with => idea.links
    # fill_in 'idea_links', :with => idea.links
    click_button 'Create'
    
    expect(page).to have_content("Ваша идея сохранена")
  end

end



# # Feature: Sign up
# #   As a visitor
# #   I want to sign up
# #   So I can visit protected areas of the site
# feature 'Sign Up', :devise do

#   # Scenario: Visitor can sign up with valid email address and password
#   #   Given I am not signed in
#   #   When I sign up with a valid email address and password
#   #   Then I see a successful sign up message
#   scenario 'visitor can sign up with valid email address and password' do
#     sign_up_with('Иван','Иванов','ivan','test@example.com', 'please123', 'please123')
#     txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
#     expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
#   end

#   # Scenario: Visitor cannot sign up with invalid email address
#   #   Given I am not signed in
#   #   When I sign up with an invalid email address
#   #   Then I see an invalid email message
#   scenario 'visitor cannot sign up with invalid email address' do
#     sign_up_with('Иван','Иванов','ivan','bogus', 'please123', 'please123')
#     expect(page).to have_content 'имеет неверное значение'
#   end

#   # Scenario: Visitor cannot sign up without password
#   #   Given I am not signed in
#   #   When I sign up without a password
#   #   Then I see a missing password message
#   scenario 'visitor cannot sign up without password' do
#     sign_up_with('Иван','Иванов','ivan','test@example.com', '', '')
#     expect(page).to have_content "не может быть пустым"
#   end

#   # Scenario: Visitor cannot sign up with a short password
#   #   Given I am not signed in
#   #   When I sign up with a short password
#   #   Then I see a 'too short password' message
#   scenario 'visitor cannot sign up with a short password' do
#     sign_up_with('Иван','Иванов','ivan','test@example.com', 'please', 'please')
#     expect(page).to have_content "недостаточной длины (не может быть меньше 8 символа)"
#   end

#   # Scenario: Visitor cannot sign up without password confirmation
#   #   Given I am not signed in
#   #   When I sign up without a password confirmation
#   #   Then I see a missing password confirmation message
#   scenario 'visitor cannot sign up without password confirmation' do
#     sign_up_with('Иван','Иванов','ivan','test@example.com', 'please123', '')
#     expect(page).to have_content "не совпадает со значением поля Пароль"
#   end

#   # Scenario: Visitor cannot sign up with mismatched password and confirmation
#   #   Given I am not signed in
#   #   When I sign up with a mismatched password confirmation
#   #   Then I should see a mismatched password message
#   scenario 'visitor cannot sign up with mismatched password and confirmation' do
#     sign_up_with('Иван','Иванов','ivan','test@example.com', 'please123', 'mismatch')
#     expect(page).to have_content "не совпадает со значением поля Пароль"
#   end

# end
