class Borrow < ApplicationRecord
  enum state: [:pending, :rejected, :accepted]
  belongs_to :user
  #belongs_to :account
end
