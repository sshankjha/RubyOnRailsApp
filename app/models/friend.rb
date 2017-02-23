class Friend < ActiveRecord::Base
  belongs_to :user
  self.primary_key = :user_id
  self.primary_key = :friend_id
end