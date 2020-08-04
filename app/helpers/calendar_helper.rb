module CalendarHelper
  def check_date event
    return Settings.color_passed if event.date_event < Time.zone.today

    event.color
  end
end
