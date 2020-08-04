class RenameColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :time_start, :start_time
    rename_column :events, :time_end, :end_time
  end
end
