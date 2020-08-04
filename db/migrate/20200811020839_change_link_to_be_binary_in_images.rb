class ChangeLinkToBeBinaryInImages < ActiveRecord::Migration[6.0]
  def change
    change_column :images, :link, :binary, :limit => 10.megabyte
  end
end
