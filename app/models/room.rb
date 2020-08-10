class Room < ApplicationRecord
  has_many :book_rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :user
  has_many :book_rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
end
