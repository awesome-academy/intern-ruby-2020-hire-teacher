class ChangeColumnTypeToEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :date_event, :datetime
  end
end
