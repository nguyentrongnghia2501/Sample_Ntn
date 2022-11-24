# frozen_string_literal: true

# Service to download ftp files from the server
class CommentsController < ApplicationController
  respond_to :html, :json
  def new
    @comment = Comment.new
    @parent = Comment.find_by(id: params[:post_parent_id])
  end

  def edit; end

  def create
    @comment = Comment.create! comment_params
    respond_to do |format|
      format.html {}
      format.js
      redirect_to root_url
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
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit :micropost_id, :user_id, :body, :post_parent_id, :image
  end

  def set_current_user
    @current_user = current_user
  end
end
