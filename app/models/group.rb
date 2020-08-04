class Group < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, uniqueness: true
end
