class Adventure < ActiveRecord::Base
  attr_accessible :from, :to, :departure_time

  # Validations
  validates :from,           presence: true
  validates :to,             presence: true
end
