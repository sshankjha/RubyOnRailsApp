class Friend < ActiveRecord::Base
  self.primary_key = :user_id
  self.primary_key = :friend_id
end