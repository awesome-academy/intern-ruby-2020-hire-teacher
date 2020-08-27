class RemoveColumnLocationToRooms < ActiveRecord::Migration[6.0]
  def up
    remove_column :rooms, :location, :string
  end

  def down
    add_column :rooms, :location, :string
  end
end
