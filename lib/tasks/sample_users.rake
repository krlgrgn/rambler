namespace :db do
  desc "Populate the DB with sample users."
  task populate_users: :environment do
    100.times do |i|
      FactoryGirl.create(:user, country: "Ireland")
    end
  end

  desc "Populate the DB with Advemtures."
  task populate_adventures: :environment do
    50.times do |i|
      FactoryGirl.create(:adventure)
    end
  end
end
