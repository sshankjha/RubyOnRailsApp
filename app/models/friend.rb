class Friend < ApplicationRecord
  validates :user_id, presence: true
  validates :user_id2, presence: true
end
