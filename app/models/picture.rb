class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :content, presence: true
  validates :content, length: { in: 1..50 }
  validates :image, presence: true

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
end
