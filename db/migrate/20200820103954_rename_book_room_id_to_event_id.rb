class RenameBookRoomIdToEventId < ActiveRecord::Migration[6.0]
  def up
    rename_column :guests, :book_room_id, :event_id
  end

  def down
    rename_column :guests, :event_id, :book_room_id
  end
end
