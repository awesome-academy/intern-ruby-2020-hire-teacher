class AddDeleteAtToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :deleted_at, :datetime
    add_index :events, :deleted_at
  end
end
