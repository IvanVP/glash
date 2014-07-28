# encoding utf-8
namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'active_support'
    require 'i18n'
    require 'populator'
    require 'faker'
    
    require 'vydumschik'
    
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
    # I18n.locale = :ru
    # I18n.reload!

    Faker::Config.locale = :ru
    
    User.populate 5 do |user|
    # 5.times do |user|
      # user.fname    = Vydumschik::Name.first_name(:female)
      user.fname    = Faker::Name.male_first_name
      user.mname    = Faker::Name.male_middle_name
      user.lname    = Faker::Name.male_last_name
      user.name     = Faker::Internet.user_name
      user.email    = Faker::Internet.email
      user.terms    = true
      # user.password = "1111"
      user.encrypted_password = "$2a$10$5ZWXwKbOWbU3hXrudhTu9ujOgZkf3E1inhaHcSspjvvsfQt2ZTRku"
      # user.password_confirmation = "1111"
      user.birthdate = 30.years.ago..19.years.ago
      user.description = Faker::Lorem.sentence
      user.created_at = 2.months.ago..Time.now
      user.confirmed_at = 1.day.ago..Time.now
      user.sign_in_count = 1..5
      user.slug = user.lname
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


# namespace :db do
#   desc "Create user records in the current database."

#   task :fake_users => :environment do
#     require 'faker'

#     @countries = ["United States", "Canada", "United Kingdom", "Germany", "Mexico"]
#     @genders = ["Male","Female"]
#     @privacy = ["members", "public"]
    
#     def random_date(params={})
#       years_back = params[:year_range] || 5
#       latest_year = params [:year_latest] || 0
#       year = (rand * (years_back)).ceil + (Time.now.year - latest_year - years_back)
#       month = (rand * 12).ceil
#       day = (rand * 31).ceil
#       date = Time.now
#       series = [date]
#       if params[:series]
#         params[:series].each do |some_time_after|
#           series << series.last + (rand * some_time_after).ceil
#         end
#         return series
#       end
#       date
#     end
    
#     100.times do
#         User.create!(
#         :first_name => Faker::Name.first_name,
#         :last_name => Faker::Name.last_name,
#         :birthdate => random_date(:year_range => 60, :year_latest => 22),
#         :created_at => random_date(:year_range => 4, :year_latest => 0),
#         :city => Faker::Lorem.words(1).to_s.capitalize,
#         :state => Faker::Address.us_state(),
#         :country => @countries.rand.to_s,
#         :password => "foobar",
#         :password_confirmation => "foobar",
#         :accepts_terms_and_conditions => true,
#         :gender => @genders.rand.to_s,
#         :email => Faker::Internet.email
#       )
#     end
#   end
# end

# require 'faker'

# namespace :db do
#   desc "Fill database with sample data"
#   task :populate => :environment do
#     Rake::Task['db:reset'].invoke
#     50.times do |n|
#       name  = Faker::Company.name
#       year = 1900+rand(111)
#       rating = 1+rand(10)
#       watched = (1 == rand(2) ? true : false)
#       imdb_id = rand(1000000)
#       Movie.create!(:name => name,
#                     :year => year,
#                     :rating => rating,
#                     :watched => watched,
#                     :imdb_id => imdb_id)
#     end
#   end
# end