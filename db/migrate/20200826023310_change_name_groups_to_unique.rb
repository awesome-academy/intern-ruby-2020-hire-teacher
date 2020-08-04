class ChangeNameGroupsToUnique < ActiveRecord::Migration[6.0]
  def up
    change_column :groups, :name, :string, unique: true
  end

  def down
    change_column :groups, :name, :string
  end
end
