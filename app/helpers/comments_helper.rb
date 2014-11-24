module CommentsHelper
  def moderator(comment)
    User.find_by(id: comment.moderator_id).fullname
  end
end
