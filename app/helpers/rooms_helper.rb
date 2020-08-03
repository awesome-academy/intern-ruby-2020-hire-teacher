module RoomsHelper
  def indexing_page object
    (object.current_page - Settings.one) * object.limit_value + Settings.one
  end

  def total_result_filter size
    size.present? ? size : Settings.zero
  end
end
