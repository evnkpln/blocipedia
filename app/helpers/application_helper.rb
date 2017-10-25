module ApplicationHelper
  def markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
  end
  def authorized_to_view?(wiki, user)
    !wiki.private? || user.admin? || user.id == wiki.user_id
  end
end
