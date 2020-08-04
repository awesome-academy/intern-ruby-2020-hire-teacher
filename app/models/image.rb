class Image < ApplicationRecord
  belongs_to :room

  mount_uploader :image, ImageUploader,
                 reject_if: proc{|param| param[:image].blank? || param[:image_cache].blank? || param[:id].blank?},
                 allow_destroy: true

  validates_processing_of :image
  validate :image_size_validation

  private

  def image_size_validation
    errors[:image] << I18n.t("image.length") if image.size > Settings.image.length
  end
end
