class BookRoom < ApplicationRecord
  has_many :guests, dependent: :destroy
  belongs_to :user, :room
end
