class UserAbility
  include CanCan::Ability

  def initialize user
    return if user.blank?

    can :read, Room, active: :opened
    can :manage, Event, user_id: user.id
    can :read, [Event, Report, Location, Country, Group]
    can %i(read delete), Report, user_id: user.id
  end
end
