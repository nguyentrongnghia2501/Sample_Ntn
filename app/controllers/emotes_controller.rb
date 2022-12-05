class EmotesController < ApplicationController
  def show
    micropost = Micropost.find_by(id: params[:micropost_id])
    emote = current_user.emotes.find_or_initialize_by(micropost: micropost, emoji: params[:emote])
    if emote.new_record?
      emote.save
      current_user.user_interactives.create

    else
      emote.destroy
    end
    redirect_to root_path
  end
end
