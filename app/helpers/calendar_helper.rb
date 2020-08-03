module CalendarHelper
  def create_week
    monday = DateTime.now - DateTime.now.cwday + 1
  end

  def next_week
    monday+7
  end

  def prev_week
    monday-7
  end

  def check_date event
    return 5 if event.date_event < Date.today

    event.color
  end
end
