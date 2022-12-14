# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  has_many :emotes, dependent: :destroy
  has_one_attached :image
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: 'must be a valid image format' },
  size: { less_than: 5.megabytes, message: 'should be less than 5MB' }

  # Returns a resized image for display. TRA VE hinh anh da sua doi
  after_destroy_commit do
    broadcast_remove_to self
  end
  after_update_commit do
    broadcast_replace_to self
  end
  def emotes_size(key)
    self.emotes.select { |e| e.emoji == key }.size
  end
end
