module CalendarHelper
  def check_date event
    return Settings.color_passed if event.date_event < Date.today

    event.color
  end
end
