class Conversation < ActiveRecord::Base
  # Validations

  # Filters

  # Relations
  has_many :conversation_mailbox_maps
  has_many :mailboxes, through: :conversation_mailbox_maps
  has_many :conversation_user_maps
  has_many :users, through: :conversation_user_maps
  has_many :messages

  # Methods
  def self.converse(message, sender, receiver)
    conversation = Conversation.new
    ActiveRecord::Base.transaction do
      # Check if a conversation between the sender and receiver already exists.
      existing_convo =  ConversationUserMap.conversation_exists?(sender, receiver)
      if existing_convo
        # IF true: reply
        Message.create!(
          body: message[:body], user: sender, conversation: existing_convo)
      else
        # IF false: create a new conversation
        ConversationMailboxMap.create!(
          conversation: conversation, mailbox: sender.mailbox)
        ConversationMailboxMap.create!(
          conversation: conversation, mailbox: receiver.mailbox)
        ConversationUserMap.create!(
          conversation: conversation, user: sender)
        ConversationUserMap.create!(
          conversation: conversation, user: receiver)
        Message.create!(
          body: message[:body], user: sender, conversation: conversation)
      end
    end
    conversation
  end

  # Private Methods
end
