class RemoveDatetimeFromEvents < ActiveRecord::Migration[6.0]
  def up
    remove_column :events, :datetime, :string
  end

  def down
    add_column :events, :datetime, :string
  end
end
