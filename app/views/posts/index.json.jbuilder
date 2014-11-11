json.array!(@posts) do |post|
  json.extract! post, :id, :name, :user_id
  json.url post_url(post, format: :json)
end
