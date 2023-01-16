# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many :comments, foreign_key: 'post_parent_id', dependent: :destroy
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :body, presence: true, allow_blank: false
  def self.schedule_comment
    @comment_count = Comment.where("DATE(created_at) = ?", Date.today-1).count
    client = Slack::Web::Client.new
    client.auth_test
    client.chat_postMessage(channel: '#test_rails', text: "có #{@comment_count}  nhận xét mới")
  end
end
