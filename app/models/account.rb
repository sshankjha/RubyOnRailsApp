class Account < ApplicationRecord
  belongs_to :user
  enum state: [:unapproved, :active, :closed], default:  :unapproved
  validates :acc_no, length: 5
end
