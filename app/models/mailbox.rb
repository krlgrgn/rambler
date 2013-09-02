class Mailbox < ActiveRecord::Base
  #attr_accessible :user_id, :user

  # Validations
  validates :user_id, presence: true

  # Filters

  # Relations
  belongs_to :user
  has_many :conversation_mailbox_maps
  has_many :conversations, through: :conversation_mailbox_maps

  # Methods

  # Private Methods
end
