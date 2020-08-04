class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.model.user.email_validate_regex
  USER_PARAMS = Settings.user_params

  enum role: {manager: 1, employee: 2, trainer: 3, trainee: 4}

  has_many :book_rooms, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :group

  validates :name, presence: true
  validates :email, presence: true,
    length: {maximum: Settings.model.user.email_max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :email, uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.model.user.password_length}, allow_nil: true
  validates :role, presence: true

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
