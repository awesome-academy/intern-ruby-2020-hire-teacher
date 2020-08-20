module CalendarHelper
  def array_color
    [["Smalt Blue", 1], ["Martinique", 2], ["Edward", 3], ["Rajah", 4]]
  end

  def check_date event
    return 5 if event.date_event < Time.zone.today

    event.color
  end
end
