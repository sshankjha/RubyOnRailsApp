json.extract! account, :id, :acc_no, :balance, :state, :created_at, :updated_at
json.url account_url(account, format: :json)