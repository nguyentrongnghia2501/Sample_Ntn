class Emote < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
   def self.schedule_emote
        @emote_count = Emote.where("DATE(created_at) = ?", Date.today-1).count
        client = Slack::Web::Client.new
        client.auth_test
        client.chat_postMessage(channel: '#test_rails', text: "có #{@emote_count} lượt bày tỏ cảm xúc mới")
  end
end
