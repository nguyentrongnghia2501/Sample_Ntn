class EmotesController < ApplicationController
  def count_emoji
    micropost = Micropost.find_by(id: params[:micropost_id])
    emote = current_user.emotes.find_or_initialize_by(micropost: micropost, emoji: params[:emote])
    if emote.new_record?
      emote.save
      ActionCable.server.broadcast("notification_channel",
          { message: "#{current_user.name} đã bày tỏ cảm xúc bài viết của bạn " })
    else
      emote.destroy
    end
    redirect_to root_url
  end
end
