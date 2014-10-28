require "faker"

FactoryGirl.define do
  factory :idea do
    title {Faker::Lorem.sentence(3, true, 2)}
    synopsis {Faker::Lorem.sentence(3, true, 5)}
    problem {Faker::Lorem.sentence(3, true, 5)}
    background {Faker::Lorem.sentence(3, true, 5)}
    solution {Faker::Lorem.sentence(3, true, 10)}
    links {Faker::Lorem.sentence(3, true, 12)}
    published true
    moderated false
    archieved false
    published_at Time.now
    moderated_at Time.now
    archieved_at nil
    views {0}
    user_id 31
    category_id 2

  end

  factory :invalid_idea, :class => "Idea"  do
    title nil
    synopsis nil
    problem nil
    background nil
    solution nil
    views nil
  end

end

# :user_id
# :category_id
# :title, :limit => 40
# :synopsis, :limit => 150
# :problem, :limit => 2500
# :background, :limit => 2500
# :solution, :limit => 2500
# :links, :limit => 1000
# :published, :default => false
# :moderated, :default => false
# :archieved, :default => false
# t.timestamps
# :published_at
# :moderated_at
# :archieved_at
# :views, default: 0

