class Room < ApplicationRecord
  CREATE_ROOM_PARAMS = [:user_id, :name, :address, :location_id,
    images_attributes: [:id, :image, :_destroy].freeze].freeze

  enum active: {locked: false, opened: true}

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

  after_update :update_event

  scope :join_location_country, ->{includes location: :country}
  scope :by_name, ->(name){where "rooms.name like ?", "%#{name}%"}
  scope :by_location, ->(id_location){includes(:location).where(locations: {id: id_location}) if id_location.present?}
  scope :by_country, ->(id_country){join_location_country.where(countries: {id: id_country}) if id_country.present?}
  scope :by_created_at, ->(date){where("date(created_at) = ? ", date) if date.present?}
  scope :by_active, ->(status){where(active: status) if status.present?}
  scope :sort_by_created_at, ->(type){order created_at: type}

  private

  def update_event
    return if opened?

    Event.where(room_id: id).update status: :inactivate
  end
end
