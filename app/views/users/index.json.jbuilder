json.array!(@users) do |user|
  json.extract! user, :name, :email, :phone, :title, :user_type
  json.url user_url(user, format: :json)
end