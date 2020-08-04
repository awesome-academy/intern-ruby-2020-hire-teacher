class ManagerAbility
  include CanCan::Ability

  def initialize user
    alias_action :create, :read, :update, :destroy, to: :crud
    return if user.blank? || !user.manager?

    can :crud, :all
  end
end
