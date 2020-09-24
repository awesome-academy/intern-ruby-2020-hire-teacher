class ManagerAbility
  include CanCan::Ability

  def initialize user
    alias_action :create, :read, :update, :destroy, to: :crud
    return if user.blank? || !user.manager?

    can :read, [Location, Country, Group]
    can %i(read update), User, group: {id: user.group_id}, role: :trainee
    can :crud, Event, group: {id: user.group_id}, user: {role: :trainee}
  end
end
