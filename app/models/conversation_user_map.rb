class ConversationUserMap < ActiveRecord::Base
  #attr_accessible :conversation, :user

  belongs_to :conversation
  belongs_to :user

  # This method checks if the conversation between exactly two users exists.
  # It returns the id of the conversation or nil if non exists.
  # TODO: Review this. I think there is a much cleaner simpler way of figuring
  # this out.
  def self.conversation_exists?(sender, receiver)
    sender_user_map = where(user_id: sender.id)
    receiver_user_map = where(user_id: receiver.id)
    # Check if there are any entries for a conversation user map first.
    if sender_user_map == [] or receiver_user_map == []
      nil
    else
      # Make sure there are only 2 entries because we are only allowing two
      # users per conversation.
      if [sender_user_map, receiver_user_map].length == 2
        # Make sure the same conversation ID exists between the two maps.
        if sender_user_map.first.conversation == receiver_user_map.first.conversation
          sender_user_map.first.conversation
        else
          nil
        end
      else
        raise Exception.new("More than two users exist in this converstion.")
      end
    end
  end

  def self.map(conversation, user)
    # Create user map.
  end
end
