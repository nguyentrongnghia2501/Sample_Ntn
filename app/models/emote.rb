class Emote < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
   def self.schedule_emote
        # @micropost_count = Micropost.where("DATE(created_at) = ?", Date.today-1).count
        @comment_count = Emote.count
        client = Slack::Web::Client.new
        client.auth_test
        client.chat_postMessage(channel: '#test_rails', text: "có #{@comment_count} lượt bày tỏ cảm xúc mới")
  end
end
