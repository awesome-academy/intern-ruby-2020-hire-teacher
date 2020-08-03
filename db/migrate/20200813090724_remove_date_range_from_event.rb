class RemoveDateRangeFromEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :date_range, :string
    remove_column :events, :color, :string
  end
end
