module CalendarHelper
  def check_date event
    return 5 if event.date_event < Date.today

    event.color
  end

  def history_position number
    if number%2 == 0
      "Left"
    else
      "Right"
    end
  end
end
