class AddStatusRoomToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :active, :boolean
  end
end
