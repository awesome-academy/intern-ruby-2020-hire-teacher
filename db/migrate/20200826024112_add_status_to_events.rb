class AddStatusToEvents < ActiveRecord::Migration[6.0]
  def up
    add_column :events, :status, :boolean
  end

  def down
    remove_column :events, :status, :boolean
  end
end
