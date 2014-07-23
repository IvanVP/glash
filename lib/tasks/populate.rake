namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    # [Category, Product, Person].each(&:delete_all)
    
    # Category.populate 20 do |category|
    #   category.name = Populator.words(1..3).titleize
    #   Product.populate 10..100 do |product|
    #     product.category_id = category.id
    #     product.name = Populator.words(1..5).titleize
    #     product.description = Populator.sentences(2..10)
    #     product.price = [4.99, 19.95, 100]
    #     product.created_at = 2.years.ago..Time.now
    #   end
    # end
    Faker::Config.locale = 'ru'
    I18n.reload!
    User.populate 5 do |user|
    # 5.times do |user|
      user.fname    = Faker::Name.first_name
      user.lname    = Faker::Name.last_name
      user.name     = Faker::Internet.user_name
      user.email    = Faker::Internet.email
      user.terms    = true
      user.encrypted_password = "b59c67bf196a4758191e42f76670ceba"
      # user.password_confirmation = "1111"
      user.birthdate = 30.years.ago..19.years.ago
      user.description = Faker::Lorem.sentence
      user.created_at = 2.months.ago..Time.now
      user.confirmed_at = 1.day.ago..Time.now
      user.sign_in_count = 1..5
      user.slug = user.name
      Contact.populate 1 do |contact|
        contact.user_id = user.id
        # user.contact.site = Faker::Internet.url
      end
      # user.phone   = Faker::PhoneNumber.phone_number
      # user.street  = Faker::Address.street_address
      # user.city    = Faker::Address.city
      # user.state   = Faker::Address.us_state_abbr
      # user.zip     = Faker::Address.zip_code
    end
  end
end

# t.string   "",                  limit: 30
#     t.string   "mname",                  limit: 70
#     t.string   "lname",                  limit: 50
#     t.string   "",                   limit: 50
#     t.string   "email",                             default: "",    null: false
#     t.string   "encrypted_password",                default: "",    null: false
#     t.boolean  "",                             default: false
#     t.date     "birthdate"
#     t.boolean  "show_birthdate",                    default: true
#     t.string   "gender",                 limit: 1
#     t.boolean  "show_gender",                       default: true
#     t.string   "foto"
#     t.text     "description"
#     t.string   "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.integer  "sign_in_count",                     default: 0,     null: false
#     t.datetime "current_sign_in_at"
#     t.datetime "last_sign_in_at"
#     t.string   "current_sign_in_ip"
#     t.string   "last_sign_in_ip"
#     t.string   "confirmation_token"
#     t.datetime "confirmed_at"
#     t.datetime "confirmation_sent_at"
#     t.string   "slug",                                              null: false
#     t.datetime "created_at"
#     t.datetime "updated_at"
#     t.string   "avatar_file_name"
#     t.string   "avatar_content_type"
#     t.integer  "avatar_file_size"
#     t.datetime "avatar_updated_at"