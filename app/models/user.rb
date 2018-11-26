class User < ApplicationRecord
  mount_uploader :icon, IconUploader
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  #validationされる前にmailを大文字から小文字に変換する
  before_validation { email.downcase! }
  #セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカラムに保存する
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :favorites, dependent: :destroy
  has_many :pictures,dependent: :destroy
  has_many :favorite_pictures, through: :favorites,source: :picture

end
