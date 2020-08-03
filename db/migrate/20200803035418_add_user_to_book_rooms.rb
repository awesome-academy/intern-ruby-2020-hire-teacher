class AddUserToBookRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :book_rooms, :user, null: false, foreign_key: true
  end
end
