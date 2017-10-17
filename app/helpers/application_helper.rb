module ApplicationHelper
  def authorized_to_view?(wiki, user)
    !wiki.private? || user.admin? || user.id == wiki.user_id
  end
end
