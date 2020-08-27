class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.model.user.email_validate_regex
  USER_PARAMS = %i(name email password password_confirmation role_id group_id).freeze

  enum role: Settings.model.user.roles.to_h

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
  after_update :send_email

  scope :get_user_now_booking, ->(room_id){where "events.room_id = ? AND DAY(events.date_event) > DAY(NOW())", room_id}
  scope :desc_user_created_at, ->{order created_at: :desc}
  scope :by_name, ->(name){where "users.name LIKE ?", "%#{name}%"}
  scope :by_email, ->(email){where "users.email LIKE ?", "%#{email}%"}
  scope :by_group, ->(group_id){where(group_id: group_id) if group_id.present?}
  scope :by_role, ->(role){where(role: role) if role.present?}
  scope :by_status, ->(status){where(activated: status) if status.present?}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end

  def send_email
    UserMailer.account_activation(self).deliver_now
  end
end
