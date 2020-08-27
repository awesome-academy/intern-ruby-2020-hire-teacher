module ReportsHelper
  def reports_tree_for reports, room, report_new
    safe_join(reports.map do |report, nested_reports|
      render(report, room: room,
        report_new: report_new) + tree_nested(nested_reports, room)
    end)
  end

  def tree_nested nested_reports, room
    return if nested_reports.empty?

    content_tag :div,
                reports_tree_for(nested_reports, room, Report.new),
                class: "replies"
  end

  def place_report parent
    if parent.present?
      "reply ..."
    else
      "report ..."
    end
  end
end
