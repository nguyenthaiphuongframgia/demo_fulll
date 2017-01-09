class User < ApplicationRecord
  has_many :recently_vieweds, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suggest_products, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: {maximum: Settings.maximum.name}
  validates :address, presence: true,
    length: {maximum: Settings.maximum.address}
  validates :phone, presence: true, length: {maximum: Settings.maximum.phone}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: Settings.maximum.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {maximum: Settings.maximum.password}, allow_nil: true

  before_save {email.downcase!}

  scope :of_ids, -> ids {where id: ids}

  scope :by_name, ->name do
    where "name LIKE '%#{name}%'" if name.present?
  end

  scope :by_search_user, ->start_day, end_day do
    where "created_at >= '#{start_day}' AND created_at <= '#{end_day}'" if start_day.present? and end_day.present?
  end

  def total_user
    User.to_a.sum {|id| item.id}
  end

  def group_by_user
    created_at.to_date.to_s(:db)
  end

  def is_user? user
    self == user
  end

  def send_order_email
    UserMailer.orders_success(self,).deliver_now
  end
end