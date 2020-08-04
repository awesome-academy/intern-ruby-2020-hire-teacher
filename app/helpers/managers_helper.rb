module ManagersHelper
  def room_option
    Settings.room_options.map{|key, val| [t(key.to_s), val]}
  end

  def event_option
    Settings.options.map{|key, val| [t(key.to_s), val]}
  end

  def activated_user_option
    Settings.activated_user_options.map{|key, val| [t(key.to_s), val]}
  end

  def load_group
    @groups = {"#{t "option.all"}": ""}
    @groups.merge! Group.pluck(:name, :id).to_h
  end

  def load_role
    @roles = {"#{t "option.all"}": ""}
    @roles.merge! Settings.model.user.roles.to_h
  end
end
