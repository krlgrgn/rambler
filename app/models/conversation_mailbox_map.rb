class ConversationMailboxMap < ActiveRecord::Base
  attr_accessible :mailbox, :conversation

  belongs_to :mailbox
  belongs_to :conversation

  def self.map(conversation, mailbox)
    # Create mailbox map
  end
end
