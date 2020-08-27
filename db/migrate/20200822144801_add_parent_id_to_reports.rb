class AddParentIdToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :parent_id, :integer
  end
end
