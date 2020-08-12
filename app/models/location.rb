class Location < ApplicationRecord
  has_many :rooms, dependent: :destroy
  belongs_to :country

  delegate :name, to: :country, prefix: :country, allow_nil: true
end
