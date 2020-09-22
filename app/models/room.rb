class Room < ApplicationRecord
  CREATE_ROOM_PARAMS = [:user_id, :name, :address, :location_id,
    images_attributes: [:id, :image, :_destroy].freeze].freeze

  enum active: {locked: false, opened: true}

  attr_accessor :previous_active

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

  before_update :update_previous_status
  after_update :notify_room_status, :change_status_room_realtime, unless: :check_status_change?

  scope :join_location_country, ->{includes location: :country}
  scope :sort_by_created_at, ->(type){order created_at: type}

  ransack_alias :title, :name_or_address

  class << self
    def ransackable_attributes _auth_object = nil
      %w(name address location_id title active created_at updated_at)
    end
  end
  ransacker :created_on do
    Arel.sql("DATE(#{table_name}.created_at)")
  end

  private

  def update_event
    return if opened?

    Event.where(room_id: id).update status: :inactivate
  end

  def notify_room_status
    events = Event.by_room_id id
    events.each do |event|
      Notification.create content: "manager #{active} room #{name}", user_id: event.user_id
    end
  end

  def update_previous_status
    self.previous_active = active_was
  end

  def check_status_change?
    active.eql? previous_active
  end

  def change_status_room_realtime
    ActionCable.server.broadcast "status_room_channel", active: render_active_lock if locked?

    ActionCable.server.broadcast "status_room_channel", active: render_active_unlock
  end

  def render_active_lock
    BusinessController.renderer.render(partial: "business/rooms/room_lock")
  end

  def render_active_unlock
    BusinessController.renderer.render(partial: "business/rooms/room_unlock")
  end
end
