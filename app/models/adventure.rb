class Adventure < ActiveRecord::Base
  attr_accessible :from, :to, :departure_time, :user, :user_id

  # Validations
  validates :from,           presence: true
  validates :to,             presence: true
  validates :user_id,        presence: true

  # Filters

  # Relations
  belongs_to :user

  # Methods

  # Private methods
end
