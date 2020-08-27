class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.model.user.email_validate_regex
  USER_PARAMS = %i(name email password password_confirmation role_id group_id).freeze

  enum role: {manager: 1, employee: 2, trainer: 3, trainee: 4}

  has_many :events, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :group

  delegate :name, to: :group, prefix: :group

  validates :name, presence: true
  validates :email, presence: true,
    uniqueness: true,
    length: {maximum: Settings.model.user.email_max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
    length: {minimum: Settings.model.user.password_length}, allow_nil: true
  validates :role, presence: true

  before_save :downcase_email

  scope :get_user_booking, ->(room_id){where "events.room_id = ?", room_id}
  scope :desc_user_created_at, ->{order created_at: :desc}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
