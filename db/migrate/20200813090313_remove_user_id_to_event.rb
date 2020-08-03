class RemoveUserIdToEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :user_id, :bigint
  end
end
