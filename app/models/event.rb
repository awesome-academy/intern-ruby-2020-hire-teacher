class Event < ApplicationRecord
  has_many :guests, dependent: :destroy
  belongs_to :user
  belongs_to :room

  delegate :name, :id, to: :user, prefix: :user
  delegate :name, :address, :id, to: :room, prefix: :room

  scope :user_room_join, ->{includes :user, :room}
  scope :join_multi_table, ->{eager_load :user, room: [location: :country]}
  scope :by_event_title, ->(name){where "events.title LIKE ?", "%#{name}%"}
  scope :by_room_name, ->(name){where "rooms.name LIKE ?", "%#{name}%"}
  scope :by_room_address, ->(name){where "rooms.address LIKE ?", "%#{name}%"}
  scope :by_location_name, ->(name){where "locations.name LIKE ?", "%#{name}%"}
  scope :by_country_name, ->(name){where "countries.name LIKE ?", "%#{name}%"}
  scope :by_user_name, ->(name){where "users.name LIKE ?", "%#{name}%"}

  def self.search_events search, option
    if option.present?
      Event.join_multi_table.send "by_#{option}", search
    else
      Event.user_room_join
    end
  end
end
