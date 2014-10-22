# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"

FactoryGirl.define do
  factory :user do
    fname {Faker::Name.first_name}
    lname {Faker::Name.last_name}
    name {Faker::Internet.user_name}
    email {Faker::Internet.safe_email}
    # sequence(:email) { |n| "ivana#{n}@example.com" } 
    # phone {Faker::PhoneNumber.phone_number}
    # phone "+7(999) 753-5555"
    password "password"
    password_confirmation "password"
    terms true
  end

  factory :invalid_user, :class => "User"  do
    fname nil
    lname nil
    name nil
    email nil
    password nil
  end
end
