class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.model.user.email_validate_regex
  PASSWORD_REGEX = Settings.password_regex
  USER_PARAMS = %i(name email password password_confirmation role group_id).freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :omniauthable, omniauth_providers: %i(facebook google_oauth2 github)

  attr_accessor :previous_activate

  enum role: Settings.model.user.roles.to_h

  has_many :events, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :reports, dependent: :destroy
  belongs_to :group

  delegate :name, to: :group, prefix: true

  accepts_nested_attributes_for :guests, reject_if: :all_blank,
    allow_destroy: true

  validates :name, presence: true
  validates :email, presence: true,
    uniqueness: {case_sensitive: true},
    length: {maximum: Settings.model.user.email_max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
    length: {minimum: Settings.model.user.password_length}, allow_nil: true
  validates :role, presence: true
  validate :password_complexity, :duplicate_password

  before_save :downcase_email, :update_previous_activate
  after_update :send_email, if: ->{(previous_activate != activated)}

  scope :get_user_now_booking, ->(room_id){where "events.room_id = ? AND events.date_event > NOW()", room_id}
  scope :sort_by_created_at, ->(type){order created_at: type}
  scope :by_name, ->(name){where "users.name LIKE ?", "%#{name}%"}
  scope :by_email, ->(email){where "users.email LIKE ?", "%#{email}%"}
  scope :by_group, ->(group_id){where(group_id: group_id) if group_id.present?}
  scope :by_role, ->(role){where(role: role) if role.present?}
  scope :by_status, ->(status){where(activated: status) if status.present?}
  scope :includes_group, ->{includes(:group).references :group}
  scope :get_trainer, ->(group_id){where(group_id: group_id, role: :trainer) if group_id.present?}
  scope :by_event_id, ->(id){where("events.id = ?", id).references :event}

  class << self
    def from_omniauth access_token
      data = access_token.info
      result = User.find_by email: data.email
      return result if result.present?

      password = Devise.friendly_token[0, 20]
      where(provider: access_token.provider, uid: access_token.uid).first_or_create do |user|
        user.email = data.email
        user.password = password
        user.password_confirmation = password
        user.name = data.name
        user.role = :employee
        user.group_id = Group.first.id
      end
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  def send_email
    ActivateUserWorker.perform_async email
  end

  def update_previous_activate
    self.previous_activate = activated_was
  end

  def password_complexity
    return unless password.present? && !password.match(PASSWORD_REGEX)

    errors.add :password, I18n.t("errors.password_regex")
  end

  def duplicate_password
    user = User.find_by email: email
    return if user.blank?

    errors.add :password, I18n.t("errors.duplicate_password") if user.valid_password?(password)
  end
end
