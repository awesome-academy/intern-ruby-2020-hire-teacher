module ApplicationHelper
  def full_title page_title
    base_title = t "base_title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def active_home home
    "active" if home == "home"
  end

  def active_room room
    "active" if room == "room"
  end

  def active_about about
    "active" if about == "about"
  end

  def active_drop drop
    "active" if drop == "drop"
  end
end
