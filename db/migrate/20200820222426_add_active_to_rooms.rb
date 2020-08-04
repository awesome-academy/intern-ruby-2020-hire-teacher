class AddActiveToRooms < ActiveRecord::Migration[6.0]
  def up
    add_column :rooms, :active, :boolean
  end

  def down
    remove_column :rooms, :active, :boolean
  end
end
