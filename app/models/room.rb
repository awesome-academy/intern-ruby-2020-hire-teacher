class Room < ApplicationRecord
  has_many :book_rooms, :reports, dependent: :destroy
  belongs_to :user
end
