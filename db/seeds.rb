# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = %W/Member Inventor Moderator Expert Author Stuff Manager Superviser Administrator/
roles.each do |role|
  Role.find_or_create_by(name: role)
end

%W/Россия Беларусь Казахстан/.each do |country|
  Country.find_or_create_by(name: country)
end