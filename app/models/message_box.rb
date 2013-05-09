class MessageBox < ActiveRecord::Base
  attr_accessible :user_id

  # Validations
  validates :user_id, presence: true

  # Filters

  # Relations
  belongs_to :user

  # Methods

  # Private Methods
end
