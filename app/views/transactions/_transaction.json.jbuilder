json.extract! transaction, :id, :from, :to, :kind, :state, :amount, :user_id, :added, :confirmed, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)