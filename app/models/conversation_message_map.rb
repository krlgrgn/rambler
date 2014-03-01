class ConversationMessageMap < ActiveRecord::Base
  #attr_accessible :conversation, :message

  belongs_to :conversation
  belongs_to :message
end
