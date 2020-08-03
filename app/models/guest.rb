class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :book_room
end
