class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    true
  end

  def show?
    # scope.where(:id => record.id).exists?
    !wiki.private? || user.admin? || user.id == wiki.user_id
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end
