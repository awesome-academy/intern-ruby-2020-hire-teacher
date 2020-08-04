class AddDefaultToActiveInRooms < ActiveRecord::Migration[6.0]
  def up
    change_column :rooms, :active, :boolean, default: true
  end

  def down
    change_column :rooms, :active, :boolean
  end
end
