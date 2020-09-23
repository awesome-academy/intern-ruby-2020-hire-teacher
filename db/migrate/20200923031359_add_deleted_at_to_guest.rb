class AddDeletedAtToGuest < ActiveRecord::Migration[6.0]
  def change
    add_column :guests, :deleted_at, :datetime
    add_index :guests, :deleted_at
  end
end
