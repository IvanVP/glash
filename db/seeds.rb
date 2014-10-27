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

users = <<EOF
Надежда;Травникова;travushka;travushka@glash.ru;F;Если мне хочется - сбудется! 
Ольга;Селезнева;olsel;olsel@glash.ru;F;Я знаю, что ничего не знаю.
Иван;Казаков;stern;stern@glash.ru;M;Самая тяжелая и неизлечимая болезнь на свете – это привычка думать по ночам... 
Федор;Минин;minin;minin@glash.ru;M;Сегодня - здесь, завтра -там.
Наталья;Федоровская;nataf;nataf@glash.ru;F;Хочу сделать фотографии самых ярких моментов жизни и обклеить ими стены комнаты.
Игорь;Цуканов;zuken;zuken@glash.ru;M;Творю, выдумываю, пробую.
Максим;Голиков;falcon;falcon@glash.ru;M;Креативный фотограф
Евгений;Евстигнеев;evev;evev@glash.ru;M;Мои идеи - всем людям!
Настя;Смирнова;nastya;nastya@glash.ru;F;Не подражайте другим. Найдите себя и будьте собой.
Олег;Бажанов;baja;baja@glash.ru;M;Креативный директор
Андрей;Белов;belyi;belyi@glash.ru;M;
Оксана;Чернова;solnce;solnce@glash.ru;F;Я - художница
Максим;Павлов;pavlov;pavlov@glash.ru;M;Художник, иллюстратор, дизайнер.
Елена;Орехова;ora;ora@glash.ru;F;Впереди у нас ещё целая жизнь, а некоторые уже говорят, что у них нет времени.
Виктор;Никитенко;nikita;nikita@glash.ru;M;3D визуализация
Вита;Веселова;vita;vita@glash.ru;F;Ученые доказали, что у хороших людей в имени есть буква В.
Маша;Краснова;mascha;mascha@glash.ru;F;С возрастом меняется многое. Меняется мнение, желания, взгляды, меняемся мы сами.
Лера;Филатова;filatova;filatova@glash.ru;F;Не повторять чужие ошибки мудро, но не интересно.
Вячеслав;Максимов;maksimov;maksimov@glash.ru;M;Поколение Next
Георгий;Новиков;novikov;novikov@glash.ru;M;Очень креативен!
Кристина;Давыдова;davydova;davydova@glash.ru;F;Копирайтер. Слоганы, тексты - для Вас.
Сергей;Волков;volkov;volkov@glash.ru;M;Я смотрю на мир через особую призму.
Юрий;Шуйский;shui;shui@glash.ru;M;Фото на профессиональном уровне
Антон;Колосов;kolosov;kolosov@glash.ru;M;Архитектурное моделирование
Марина;Исакова;isakova;isakova@glash.ru;F;Дизайнер
Станислав;Назиров;nazirov;nazirov@glash.ru;M;Спросить всегда стоит. Отвечать - не всегда.
Виталий;Селезнев;selezen;selezen@glash.ru;M;В споре рождается коллективное заблуждение, а истиной мы его называем для краткости.
Михаил;Протопопов;proto;proto@glash.ru;M;У Вас тоже утром появляется прилив энергии и хочется творить что-то доброе? 
Руслан;Егоров;egorov;egorov@glash.ru;M;
Нели;Закирова;zakirova;zakirova@glash.ru;F;Умей смеяться над собой
EOF

users.each_line do |str|
  a=[]
  a=str.split(";")
  unless User.find_by(name: a[2])
    u = User.new(fname: a[0], lname: a[1], name: a[2], email: a[3], slug: a[2],
                  gender: a[4], show_gender: true, description: a[5].chomp,
                        created_at: Time.now - (2+rand(31)).days, updated_at: Time.now-  (rand(40)).hours, terms: true,
                        password: "11111111", confirmed_at: Time.now)
    u.save!(:validate => false)
  end
end


categories = %W/Гаджеты Для\ дома Для\ дачи Для\ детей Здоровье Путешествия Разное /
i=1
categories.each do |category|
  Category.find_or_create_by(name: category, order: i)
  i += 1
end