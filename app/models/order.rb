class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  belongs_to :user

  validates :receiver_name, presence: true, length: {maximum: Settings.maximum.name}
  validates :receiver_address, presence: true, length: {maximum: Settings.maximum.address}
  validates :receiver_phone, presence: true, length: {maximum: Settings.maximum.phone}
  validates :user_id, presence: true

  scope :by_search, ->start_day, end_day do
    where "Date(created_at) >= '#{start_day}' AND Date(created_at) <= '#{end_day}'" if start_day.present? and end_day.present?
  end

  def total_price
    order_items.includes(:product).to_a.sum {|item| item.total_price}
  end

  def group_by_order
    created_at.to_date.to_s(:db)
  end

  def total_quantity
    order_items.to_a.sum {|item| item.quantity}
  end

  scope :by_name, ->name do
    where "receiver_name LIKE '%#{name}%'" if name.present?
  end

  scope :by_status, ->status do
    where "status = #{status}" if status.present?
  end
end
