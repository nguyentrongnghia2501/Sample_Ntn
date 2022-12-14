class EmotesController < ApplicationController
  def count_emoji
    micropost = Micropost.find_by(id: params[:micropost_id])
    emote = current_user.emotes.find_or_initialize_by(micropost: micropost, emoji: params[:emote])
    if emote.new_record?
      emote.save
    else
      emote.destroy
    end
    redirect_to root_url
  end
end
