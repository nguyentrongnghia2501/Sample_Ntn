# frozen_string_literal: true

# Service to download ftp files from the server
class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy
  def index
    @micropost = micropost.all
    @notifications = current_user.notifications.reverse
    current_user.notifications.mark_as_read!
  end
  def show
    mark_notifications_as_read
  end
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    if request.referrer.nil? || request.referrer == microposts_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
  def mark_notifications_as_read
    if current_user
      notifications_to_mark_as_read = @micropost.notifications_as_post.where(recipient: curent_user)
      notifications_to_mark_as_read.update_all(read_at: time.zone.now)
    end
  end
end
