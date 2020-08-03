class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :title
      t.string :date_range
      t.datetime :start
      t.datetime :end
      t.string :color
      t.references :user
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
