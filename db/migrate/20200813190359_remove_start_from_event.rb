class RemoveStartFromEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :start, :datetime
    remove_column :events, :end, :datetime
  end
end
