class RemoveDatetimeFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :datetime, :string
  end
end
