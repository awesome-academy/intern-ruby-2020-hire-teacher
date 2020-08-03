class AddColorToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :color, :integer
  end
end
