class User < ApplicationRecord
  has_many :book_rooms, :guests, :rooms, :reports, dependent: :destroy
  belongs_to :role, :group
end
