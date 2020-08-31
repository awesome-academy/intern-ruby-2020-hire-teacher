module ApplicationHelper
  def full_title page_title
    base_title = t "base_title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      text = "toastr.#{type}('#{message}')"
      flash_messages << content_tag(:script, text) if message
    end
    safe_join(flash_messages)
  end
end
