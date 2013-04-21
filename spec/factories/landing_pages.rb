# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :landing_page do |f|
    f.email { Faker::Internet.email }
  end
end
