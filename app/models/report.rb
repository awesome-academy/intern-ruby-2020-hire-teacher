class Report < ApplicationRecord
  REPORT_PARAMS = %i(room_id user_id comment).freeze

  belongs_to :user
  belongs_to :room

  acts_as_tree order: "created_at DESC"

  validates :comment, presence: true, allow_nil: true,
    length: {maximum: Settings.report.max_length}

  delegate :name, to: :user, prefix: :user, allow_nil: true
end
