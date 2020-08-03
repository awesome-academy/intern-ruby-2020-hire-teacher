class BookRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :guests, dependent: :destroy
end
