module ManagersHelper
  def room_option
    Settings.room_options.map{|key, val| [t(key.to_s), val]}
  end

  def event_option
    Settings.options.map{|key, val| [t(key.to_s), val]}
  end
end
