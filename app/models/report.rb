class Report < ApplicationRecord
  belongs_to :user
  belongs_to :room

  delegate :name, to: :user, prefix: :user, allow_nil: true
end
