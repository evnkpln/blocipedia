class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, post)
    @user = user
    @wiki = wiki
  end

  def index?
    true
  end

  def show?
    # scope.where(:id => record.id).exists?
    true
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
