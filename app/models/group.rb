class Group < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, uniqueness: {case_sensitive: true}
end
