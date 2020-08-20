class AddColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :color, :int
    add_column :events, :date_event, :string
    add_column :events, :datetime, :string
  end
end
