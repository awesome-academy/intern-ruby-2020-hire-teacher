class RemoveCommentFromReport < ActiveRecord::Migration[6.0]
  def change
    remove_column :reports, :comment, :string
  end
end
