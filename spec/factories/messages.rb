# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do |f|
    f.body { Faker::Lorem.sentence }
    user
    conversation
  end
end
