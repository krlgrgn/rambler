require 'faker'

FactoryGirl.define do
  factory :user do |f|
    PASSWORD = "password"
    f.email                    { Faker::Internet.email }
    f.first_name               { Faker::Name.first_name }
    f.last_name                { Faker::Name.last_name }
    f.city                     { Faker::Address.city }
    f.state                    { Faker::Address.state }
    f.country                  { Faker::Address.country}
    f.about                    { Faker::Lorem.sentence }
    f.password                 { PASSWORD }
    f.password_confirmation    { PASSWORD }

    factory :admin do
      admin true
    end
  end
end
