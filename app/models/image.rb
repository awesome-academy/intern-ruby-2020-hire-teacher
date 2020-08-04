class Image < ApplicationRecord
  belongs_to :room

  mount_uploader :image, ImageUploader

  validate :image_size_validation

  def image_size_validation
    errors[:image] << I18n.t("image.length") if image.size > Settings.image.length
  end
end
