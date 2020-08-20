class Event < ApplicationRecord
  has_many :guests, dependent: :destroy
  belongs_to :user
  belongs_to :room
end
