class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name , presence: true , length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email , presence: true, length: { maximum:255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :phone, presence: true, length: {minimum: 10, maximum: 10}
  validates :password, presence: true, length: { minimum: 4 }
  has_many  :accounts
  has_many  :friends

  def self.search(search)
    if search
      where('name LIKE ? and id != ? AND is_admin = ?', "%#{search}%", current_user[:id], false)
    else
      where('id != ? AND is_admin = ?', current_user[:id], false)
    end
  end
#
end
