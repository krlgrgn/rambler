# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mailbox do |f|
    user

    factory :mailbox_with_conversations do

      after(:build) do |mailbox, evaluator|
        convo = FactoryGirl.create(:conversation)
        FactoryGirl.create_list(:conversation_mailbox_map, 5, mailbox: mailbox, conversation: convo)
      end
    end
  end
end
