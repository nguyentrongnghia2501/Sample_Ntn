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


  private

  def notify_recipient
    CommentNotification.with(comment: self,micropost: micropost).deliver_later(micropost.user)
  end
  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end
