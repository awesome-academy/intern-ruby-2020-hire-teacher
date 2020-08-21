module ReportsHelper
  def day_report date
    many_day = Time.zone.today - date.to_date
    if many_day > Settings.many_day
      date.strftime(Settings.format_date)
    else
      [many_day.to_i, t("ago")].join(" ")
    end
  end

  def reports_tree_for reports, room, report_new
    safe_join(reports.map do |report, nested_reports|
      render(report, room: room,
        report_new: report_new) + tree(nested_reports, room)
    end)
  end

  def tree nested_reports, room
    return if nested_reports.empty?

    content_tag :div,
                reports_tree_for(nested_reports, room, Report.new),
                class: "replies"
  end
end
