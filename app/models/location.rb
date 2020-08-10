class Location < ApplicationRecord
  belongs_to :country
  has_many :rooms, dependent: :destroy
end
