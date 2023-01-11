# frozen_string_literal: true

# Service to download ftp files from the server
class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  include SessionsHelper

  private

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
  # notifications
  def set_notifications
    notifications = Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end
end
