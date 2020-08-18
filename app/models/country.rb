class Country < ApplicationRecord
  has_many :locations, dependent: :destroy
  has_many :rooms, through: :locations
end
