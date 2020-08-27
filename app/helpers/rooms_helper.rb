module RoomsHelper
  def indexing_page object
    (object.current_page - Settings.one) * object.limit_value + Settings.one
  end

  def total_result_filter size
    size.present? ? size : Settings.zero
  end

  def page_sum object
    "#{t 'managers.page.current_page'} #{object.current_page} / #{object.total_pages}"
  end

  def record_sum object
    "#{t 'managers.page.record'} #{indexing_page object} - #{object.count - 1 + indexing_page(object)}"
  end
end
