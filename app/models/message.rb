class Message < ActiveRecord::Base
  #attr_accessible :body,
  #                :user, :user_id,
  #                :conversation, :conversation_id

  # Validations
  validates :body, presence: true
  validates :user_id, presence: true
  validates :conversation_id, presence: true

  # Filters

  # Relations
  # Originally: :message_conversation_maps
  #Can change this to belongs_to :conversation
    #because a unique message cant belong to more than one conversation
    #so there is no need for the conversation message map.
  belongs_to :conversation
  belongs_to :user

  # Methods

  # Private Methods
end
