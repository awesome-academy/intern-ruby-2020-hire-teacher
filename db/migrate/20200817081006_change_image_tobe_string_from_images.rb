class ChangeImageTobeStringFromImages < ActiveRecord::Migration[6.0]
  def change
    change_column :images, :image, :string
  end
end
