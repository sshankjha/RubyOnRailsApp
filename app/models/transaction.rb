class Transaction < ApplicationRecord
  enum state: [:pending, :rejected, :accepted]
  enum kind: [:deposit, :withdraw, :transfer]
  belongs_to :user

end
