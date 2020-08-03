class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
