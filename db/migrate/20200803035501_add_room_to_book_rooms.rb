class AddRoomToBookRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :book_rooms, :room, null: false, foreign_key: true
  end
end
