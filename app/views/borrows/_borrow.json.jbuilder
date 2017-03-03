json.extract! borrow, :id, :user_id, :friend_id, :friend_name, :amount, :state, :created_at, :updated_at
json.url borrow_url(borrow, format: :json)