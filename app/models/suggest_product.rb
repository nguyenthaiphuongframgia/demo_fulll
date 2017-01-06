class SuggestProduct < ApplicationRecord
  belongs_to :category
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :name,  presence: true, length: {maximum: Settings.maximum.name}
  validates :price, presence: true, numericality: true
  validates :user_id, presence: true
  validates :category_id, presence: true

  scope :by_name, ->name do
    where "name LIKE '%#{name}%'" if name.present?
  end
end
