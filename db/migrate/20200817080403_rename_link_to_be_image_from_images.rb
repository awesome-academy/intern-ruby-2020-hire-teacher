class RenameLinkToBeImageFromImages < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :link, :image
  end
end
