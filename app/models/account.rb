class Account < ApplicationRecord
  belongs_to :user
  enum state: [:inactive, :active, :closed]
  validates :acc_no, length: {minimum:9, maximum:9}, uniqueness: {case_sensitive: false}

end
