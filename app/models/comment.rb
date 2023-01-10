# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many :comments, foreign_key: 'post_parent_id', dependent: :destroy

  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :body, presence: true, allow_blank: false
  # notifications

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'
  after_commit :actions

  private
  def actions

  end  
  def notify_recipient
   @noti = CommentNotification.with(comment: self,micropost: micropost).deliver_later(micropost.user)
    # ActionCable.server.broadcast("notification_channel",{ message: "co thong bao" })
  end
  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end
