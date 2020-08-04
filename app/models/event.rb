class Event < ApplicationRecord
  has_many :guests, dependent: :destroy
  belongs_to :user
  belongs_to :room

  delegate :name, :id, to: :user, prefix: :user
end
