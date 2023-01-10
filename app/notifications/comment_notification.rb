# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :action_cable
  deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #


  def message
    @micropost = Micropost.find(params[:comment][:micropost_id])
    @comment = Comment.find(params[:comment][:id])
    @user = User.find(@comment.user_id)
    "#{@user.name} đã bình luận bài viết của bạn : #{@micropost.content.truncate(10)}"
  end
   def ac
     
    end
  # def comment
  #   params[:message]
  # end
  # def creator
  #   comment.user
  # end
  # def post
  #   comment.micropost
  # end
  #
  def url
    micropost_path(Micropost.find(params[:comment][:micropost_id]))
  end
end
