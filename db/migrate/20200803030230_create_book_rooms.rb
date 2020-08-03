class CreateBookRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :book_rooms do |t|
      t.string :title
      t.string :description
      t.datetime :time_start
      t.datetime :time_end
      t.boolean :status, default: true
      t.string :message

      t.timestamps
    end
  end
end
