class Event < ApplicationRecord
  EVENT_PARAMS = [:title, :start_time, :end_time,
                  :user_id, :room_id, :color, :description,
                  :date_event,
                  guests_attributes: [:user_id, :_destroy].freeze].freeze
  attr_accessor :previous_status

  enum status: {inactivate: false, activate: true}

  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, reject_if: :all_blank,
    allow_destroy: true
  belongs_to :user
  belongs_to :room
  belongs_to :user

  delegate :name, :id, to: :user, prefix: :user
  delegate :name, :address, :id, :active, to: :room, prefix: :room

  validates :title, presence: true,
    length: {maximum: Settings.event.title.max_length}
  validates :date_event, :start_time, :end_time, presence: true
  validates :description, presence: true, allow_nil: true,
    length: {maximum: Settings.event.desc.max_length}
  validate :end_time_after_start_time, :day_off, :during_day
  validates_time :start_time, between: Settings.event.time.start...Settings.event.time.end,
    message: I18n.t("business.model.event.between_after")
  validates_time :end_time, between: Settings.event.time.start...Settings.event.time.end,
    message: I18n.t("business.model.event.between_before")
  validates_date :date_event, on_or_after: Time.zone.today,
    message: I18n.t("business.model.event.on_or_after")

  before_update :update_previous_status
  after_update :send_email, unless: :check_send_mail?

  scope :in_day, ->(date_event, room_id){where(date_event: date_event, room_id: room_id)}
  scope :check_event_time_with_calendar, (lambda do |start_time, end_time|
    where ":start_time BETWEEN start_time AND end_time
      OR end_time BETWEEN start_time AND end_time", start_time: start_time, end_time: end_time
  end)
  scope :user_room_join, ->{includes :user, :room}
  scope :join_multi_table, ->{eager_load :user, room: [location: :country]}
  scope :by_event_title, ->(name){where "events.title LIKE ?", "%#{name}%"}
  scope :by_room_name, ->(name){where "rooms.name LIKE ?", "%#{name}%"}
  scope :by_room_address, ->(name){where "rooms.address LIKE ?", "%#{name}%"}
  scope :by_location_name, ->(name){where "locations.name LIKE ?", "%#{name}%"}
  scope :by_country_name, ->(name){where "countries.name LIKE ?", "%#{name}%"}
  scope :by_user_name, ->(name){where "users.name LIKE ?", "%#{name}%"}
  scope :sort_by_date_event, ->(type){order date_event: type}
  scope :by_room_id, ->(room_id){where room_id: room_id if room_id.present?}
  scope :by_trainee, (lambda do |group_id|
    joins(:user).where(users: {group_id: group_id, role: :trainee})
  end)

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    return unless end_time < start_time

    errors.add(:end_time, I18n.t("business.model.event.end_time_after_start_time"))
  end

  def day_off
    return if date_event.blank?

    errors[:date_event] << I18n.t("business.model.event.day_off") if date_event.sunday? || date_event.saturday?
  end

  class << self
    def search_events search, option
      if option.present?
        Event.join_multi_table.send "by_#{option}", search
      else
        Event.user_room_join
      end
    end
  end

  def during_day
    events_during = Event.in_day(date_event, room_id).check_event_time_with_calendar(start_time, end_time)
    errors.add(:system, I18n.t("business.model.event.room_ready")) if events_during.present?
  end

  def send_email
    MailToGuestWorker.perform_async id
  end

  def update_previous_status
    self.previous_status = status_was
  end

  def check_send_mail?
    return true if previous_status == status || end_time.blank? || start_time.blank? || end_time <= start_time
  end
end
