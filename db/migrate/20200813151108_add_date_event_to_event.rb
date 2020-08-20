class AddDateEventToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :date_event, :datetime
  end
end
