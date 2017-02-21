class Account < ApplicationRecord
  belongs_to :user
  enum state: [:inactive, :active, :closed]
end
