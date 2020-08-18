class Room < ApplicationRecord
  CREATE_ROOM_PARAMS = [:user_id, :name, :address, :location_id,
    images_attributes: [:id, :image, :_destroy].freeze
  ].freeze

  has_many :book_rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :book_rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :user
  belongs_to :location

  validates :user_id, presence: true
  validates :address, presence: true
  validates :location_id, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  delegate :name, to: :location, prefix: :location, allow_nil: true
end
