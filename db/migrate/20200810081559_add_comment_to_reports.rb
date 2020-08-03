class AddCommentToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :comment, :text
  end
end
