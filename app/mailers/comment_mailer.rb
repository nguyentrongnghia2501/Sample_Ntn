class CommentMailer < ApplicationMailer
	def new_comment(comment, user)
		@comment = comment
  		mail(
				to: user.email,
				subject: "New comment on your micropost",
			)
	end
end
