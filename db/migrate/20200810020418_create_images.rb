class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :link
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
