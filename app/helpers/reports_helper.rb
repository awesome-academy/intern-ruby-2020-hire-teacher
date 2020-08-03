module ReportsHelper
  def day_report date
    many_day = Time.zone.today - date.to_date
    if many_day > Settings.many_day
      date.strftime(Settings.format_date)
    else
      [many_day.to_i, t("ago")].join(" ")
    end
  end
end
