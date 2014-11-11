json.array!(@contents) do |content|
  json.extract! content, :id, :link, :post_id, :name
  json.url content_url(content, format: :json)
end
