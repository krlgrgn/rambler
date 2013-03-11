FactoryGirl.define do
  factory :adventure do |f|
    f.from           { Faker::Address.city }
    f.to             { Faker::Address.city }
    f.departure_time { Time.now }
    user
  end
end
