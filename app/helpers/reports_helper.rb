module ReportsHelper
  def reports_tree_for reports, room, report_new
    safe_join(reports.map do |report, nested_reports|
      render(report, room: room,
        report_new: report_new) + tree_nested(nested_reports, room)
    end)
  end

  def tree_nested nested_reports, room
    return if nested_reports.empty?

    report_id = nested_reports.first[0].parent_id
    content_tag :div,
                reports_tree_for(nested_reports, room, Report.new),
                class: "replies form-report-" + report_id.to_s + " replies-" + report_id.to_s + " old-replies"
  end

  def place_report parent
    if parent.present?
      "reply ..."
    else
      "report ..."
    end
  end

  def total_report_children report
    report.self_and_descendants.size - 1
  end
end
