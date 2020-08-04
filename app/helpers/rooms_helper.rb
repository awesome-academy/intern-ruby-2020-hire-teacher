module RoomsHelper
  def indexing_page object
    (object.current_page - 1) * object.limit_value + 1
  end
end
