class Room < ApplicationRecord
  CREATE_ROOM_PARAMS = [:user_id, :name, :address, :location_id,
    images_attributes: [:id, :image, :_destroy].freeze].freeze

  has_many :events, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :location

  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  delegate :name, to: :location, prefix: :location, allow_nil: true

  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: Settings.room.name.maximum}
  validates :address, presence: true, length: {maximum: Settings.room.address.maximum}
  validates :location_id, presence: true

  scope :by_name, ->(name){where("rooms.name like ?", "%#{name}%")}
  scope :by_location, ->(id){includes(:location).where(locations: {id: id})}
  scope :by_country, ->(id){includes(location: :country).where(countries: {id: id})}
end
