class RenameBookRooms < ActiveRecord::Migration[6.0]
  def up
    rename_table :book_rooms, :events
  end

  def down
    rename_table :events, :book_rooms
  end
end
