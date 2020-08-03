class Event < ApplicationRecord
  EVENT_PARAMS = Settings.event_params.freeze

  has_many :guests, dependent: :destroy
  belongs_to :room
  belongs_to :user

  validates :title, presence: true,
    length: {maximum: Settings.event.title.max_length}
  validates :date_event, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :description, presence: true, allow_nil: true,
    length: {maximum: Settings.event.desc.max_length}
  validate :end_time_after_start_time, :day_off
  validates_time :start_time, between: Settings.event.time.start...Settings.event.time.end,
    message: I18n.t("business.model.event.between_after")
  validates_time :end_time, between: Settings.event.time.start...Settings.event.time.end,
    message: I18n.t("business.model.event.between_before")
  validates_date :date_event , on_or_after: Date.today,
    message: I18n.t("business.model.event.on_or_after")

  delegate :name, :id, to: :user, prefix: :user

  private
  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t("business.model.event.end_time_after_start_time"))
    end
  end

  def day_off
    return if date_event.blank?

    errors[:date_event] << I18n.t("business.model.event.day_off") if (date_event.sunday? || date_event.saturday? )
  end
end
