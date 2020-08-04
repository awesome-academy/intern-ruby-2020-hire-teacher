class AddDefaultStatusToEvents < ActiveRecord::Migration[6.0]
  def up
    change_column :events, :status, :boolean, default: true
  end

  def down
    change_column :events, :status, :boolean
  end
end
