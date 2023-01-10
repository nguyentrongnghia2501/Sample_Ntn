# frozen_string_literal: true

# Service to download ftp files from the server
class CommentsController < ApplicationController
  respond_to :html, :json
  before_action :correct_user, only: :destroy
  before_action :logged_in_user, only: %i[create destroy]
  def new
    @comment = Comment.new
    @parent = Comment.find_by(id: params[:post_parent_id])
  end

  def edit; end

  def create
    @comment = Comment.create! comment_params
    respond_to do |format|
      if @comment.save
        ActionCable.server.broadcast("notification_channel",
          { message: "#{current_user.name} đã bình luận bài viết của bạn " })
         
        

        
        # CommentMailer.new_comment(user, @comment).deliver_now
        format.html { redirect_to @comment, notice: 'comment was successfully created.' }
        format.js   {}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.js
      redirect_to root_url
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comment_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render layout: false }
    end

  end


  private

  def comment_params
    params.require(:comment).permit :micropost_id, :user_id, :body, :post_parent_id, :image
  end
  def correct_user
     @comment = Comment.find_by(id: params[:id])
     if @comment.user
       redirect_to root_url, :alert => "You are not allowed" unless current_user.admin? || @comment.user == current_user
     else
       redirect_to root_url, :alert => "You are not allowed" unless current_user.admin?
     end
  end

end
