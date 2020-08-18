class ChangeRoleAddDefaultInUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :role, :integer, default: :employee
  end

  def down
    change_column :users, :admin, :boolean, default: nil
  end
end
